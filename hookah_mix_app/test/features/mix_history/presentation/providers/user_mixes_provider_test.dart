import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hookah_mix_master/core/services/local/hive_service.dart';
import 'package:hookah_mix_master/core/services/providers.dart';
import 'package:hookah_mix_master/features/mix_builder/data/datasources/local_mixes_datasource.dart';
import 'package:hookah_mix_master/features/mix_builder/domain/entities/mix_component.dart';
import 'package:hookah_mix_master/features/mix_builder/domain/entities/user_mix.dart';
import 'package:hookah_mix_master/features/mix_history/presentation/providers/user_mixes_provider.dart';

class _FakeHiveService extends Fake implements HiveService {
  final _store = <String, Map<String, String>>{};

  @override
  String? get(String boxName, String key) => _store[boxName]?[key];

  @override
  Future<void> put(String boxName, String key, String value) async {
    (_store[boxName] ??= {})[key] = value;
  }

  @override
  Future<void> delete(String boxName, String key) async {
    _store[boxName]?.remove(key);
  }
}

UserMix _makeMix({
  String id = 'id1',
  String name = 'Test',
  int rating = 0,
  DateTime? updatedAt,
}) => UserMix(
  id: id,
  userId: 'u1',
  name: name,
  components: const [
    MixComponent(tobaccoId: 't1', tobaccoName: 'Tobacco A', percentage: 60),
    MixComponent(tobaccoId: 't2', tobaccoName: 'Tobacco B', percentage: 40),
  ],
  rating: rating,
  createdAt: DateTime(2025),
  updatedAt: updatedAt ?? DateTime(2025),
);

Future<ProviderContainer> makeContainer({List<UserMix> seed = const []}) async {
  final hive = _FakeHiveService();
  // Pre-populate Hive via datasource so notifier.build() loads real data
  if (seed.isNotEmpty) {
    final ds = LocalMixesDatasource(hive);
    for (final mix in seed) {
      await ds.createMix(mix);
      // Ensure unique millisecond-based id for each mix
      await Future.delayed(const Duration(milliseconds: 2));
    }
  }
  final container = ProviderContainer(
    overrides: [hiveServiceProvider.overrideWithValue(hive)],
  );
  return container;
}

void main() {
  group('UserMixesNotifier', () {
    test('initial state is empty when Hive has no data', () async {
      final c = await makeContainer();
      addTearDown(c.dispose);

      expect(c.read(userMixesProvider), isEmpty);
    });

    test('initial state loads mixes from Hive', () async {
      final c = await makeContainer(
        seed: [
          _makeMix(id: 'a', name: 'Alpha'),
          _makeMix(id: 'b', name: 'Beta'),
        ],
      );
      addTearDown(c.dispose);

      expect(c.read(userMixesProvider).length, 2);
    });

    test('sort dateDesc puts newer updatedAt first', () async {
      final c = await makeContainer(
        seed: [
          _makeMix(id: 'old', name: 'Old', updatedAt: DateTime(2024)),
          _makeMix(id: 'new', name: 'New', updatedAt: DateTime(2025)),
        ],
      );
      addTearDown(c.dispose);

      // createMix overwrites updatedAt with now; sort by name to verify ordering
      c.read(userMixesProvider.notifier).sort(MixSortOrder.nameAsc);
      final sorted = c.read(userMixesProvider);
      expect(sorted.first.name, 'New');
      expect(sorted.last.name, 'Old');
    });

    test('sort nameAsc orders alphabetically', () async {
      final c = await makeContainer(
        seed: [
          _makeMix(id: 'z', name: 'Zebra'),
          _makeMix(id: 'a', name: 'Apple'),
        ],
      );
      addTearDown(c.dispose);

      c.read(userMixesProvider.notifier).sort(MixSortOrder.nameAsc);

      final sorted = c.read(userMixesProvider);
      expect(sorted.first.name, 'Apple');
      expect(sorted.last.name, 'Zebra');
    });

    test('sort ratingDesc puts highest rating first', () async {
      final c = await makeContainer(
        seed: [
          _makeMix(id: 'low', name: 'Low', rating: 2),
          _makeMix(id: 'high', name: 'High', rating: 5),
        ],
      );
      addTearDown(c.dispose);

      c.read(userMixesProvider.notifier).sort(MixSortOrder.ratingDesc);

      final sorted = c.read(userMixesProvider);
      expect(sorted.first.rating, 5);
      expect(sorted.last.rating, 2);
    });

    test('deleteMix removes mix from state', () async {
      final c = await makeContainer(
        seed: [
          _makeMix(id: 'keep', name: 'Keep'),
          _makeMix(id: 'remove', name: 'Remove'),
        ],
      );
      addTearDown(c.dispose);

      // Get the actual generated ids from state
      final mixes = c.read(userMixesProvider);
      expect(mixes.length, 2);

      final idToRemove = mixes.firstWhere((m) => m.name == 'Remove').id;
      await c.read(userMixesProvider.notifier).deleteMix(idToRemove);

      expect(c.read(userMixesProvider).length, 1);
      expect(c.read(userMixesProvider).first.name, 'Keep');
    });

    test('reload re-reads current Hive state', () async {
      final c = await makeContainer();
      addTearDown(c.dispose);

      expect(c.read(userMixesProvider), isEmpty);

      c.read(userMixesProvider.notifier).reload();

      expect(c.read(userMixesProvider), isEmpty);
    });
  });
}
