import 'package:hookah_mix_master/core/services/providers.dart';
import 'package:hookah_mix_master/features/mix_builder/data/datasources/local_mixes_datasource.dart';
import 'package:hookah_mix_master/features/mix_builder/domain/entities/user_mix.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_mixes_provider.g.dart';

enum MixSortOrder { dateDesc, dateAsc, ratingDesc, nameAsc }

@Riverpod(keepAlive: true)
class UserMixesNotifier extends _$UserMixesNotifier {
  @override
  List<UserMix> build() => _load();

  void reload() => state = _load();

  void sort(MixSortOrder order) {
    final sorted = [...state];
    switch (order) {
      case MixSortOrder.dateDesc:
        sorted.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
      case MixSortOrder.dateAsc:
        sorted.sort((a, b) => a.updatedAt.compareTo(b.updatedAt));
      case MixSortOrder.ratingDesc:
        sorted.sort((a, b) => b.rating.compareTo(a.rating));
      case MixSortOrder.nameAsc:
        sorted.sort((a, b) => a.name.compareTo(b.name));
    }
    state = sorted;
  }

  Future<void> deleteMix(String mixId) async {
    final ds = LocalMixesDatasource(ref.read(hiveServiceProvider));
    await ds.deleteMix(mixId);
    state = state.where((m) => m.id != mixId).toList();
  }

  List<UserMix> _load() =>
      LocalMixesDatasource(ref.read(hiveServiceProvider)).getUserMixes();
}
