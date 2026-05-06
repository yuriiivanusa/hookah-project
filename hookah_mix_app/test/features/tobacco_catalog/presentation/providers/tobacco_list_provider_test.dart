import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hookah_mix_master/features/tobacco_catalog/domain/entities/brand.dart';
import 'package:hookah_mix_master/features/tobacco_catalog/domain/entities/taste_profile.dart';
import 'package:hookah_mix_master/features/tobacco_catalog/domain/entities/tobacco.dart';
import 'package:hookah_mix_master/features/tobacco_catalog/domain/entities/tobacco_filter.dart';
import 'package:hookah_mix_master/features/tobacco_catalog/domain/repositories/tobacco_repository.dart';
import 'package:hookah_mix_master/features/tobacco_catalog/presentation/providers/catalog_filter_state.dart';
import 'package:hookah_mix_master/features/tobacco_catalog/presentation/providers/tobacco_providers.dart';
import 'package:mocktail/mocktail.dart';

class _MockRepo extends Mock implements TobaccoRepository {}

Tobacco _makeTobacco({
  String id = 't1',
  String nameEn = 'Blue Mist',
  int strength = 3,
  List<String> flavorCategories = const ['fruity'],
  int popularity = 90,
}) => Tobacco(
  id: id,
  brandId: 'b1',
  brandName: 'Fumari',
  brandCountry: 'US',
  nameEn: nameEn,
  nameUk: 'Назва',
  leafType: 'virginia',
  strength: strength,
  flavorCategories: flavorCategories,
  tasteNotes: const [],
  tasteProfile: const TasteProfile(),
  descriptionEn: 'Desc',
  descriptionUk: 'Опис',
  popularity: popularity,
);

void main() {
  setUpAll(() => registerFallbackValue(const TobaccoFilter()));

  late _MockRepo repo;

  setUp(() {
    repo = _MockRepo();
    when(() => repo.getTobaccos()).thenAnswer((_) async => [_makeTobacco()]);
    when(() => repo.getBrands()).thenAnswer((_) async => <Brand>[]);
    when(() => repo.filterTobaccos(any())).thenAnswer((inv) async {
      final filter = inv.positionalArguments.first as TobaccoFilter;
      var all = [_makeTobacco()];
      if (filter.query.isNotEmpty) {
        all = all
            .where((t) => t.nameEn.toLowerCase().contains(filter.query.toLowerCase()))
            .toList();
      }
      return all;
    });
  });

  ProviderContainer makeContainer() =>
      ProviderContainer(overrides: [tobaccoRepositoryProvider.overrideWithValue(repo)]);

  group('filteredTobaccoListProvider', () {
    test('returns tobacco list with default filter', () async {
      final container = makeContainer();
      addTearDown(container.dispose);

      final result = await container.read(filteredTobaccoListProvider.future);
      expect(result.length, 1);
      expect(result.first.nameEn, 'Blue Mist');
    });

    test('re-fetches when query filter changes', () async {
      final container = makeContainer();
      addTearDown(container.dispose);

      await container.read(filteredTobaccoListProvider.future);

      container.read(catalogFilterProvider.notifier).setQuery('zzz');

      final filtered = await container.read(filteredTobaccoListProvider.future);
      expect(filtered, isEmpty);
    });

    test('clearFilters resets to default and returns all', () async {
      final container = makeContainer();
      addTearDown(container.dispose);

      container.read(catalogFilterProvider.notifier).setQuery('zzz');
      container.read(catalogFilterProvider.notifier).clearFilters();

      final result = await container.read(filteredTobaccoListProvider.future);
      expect(result.length, 1);
    });
  });
}
