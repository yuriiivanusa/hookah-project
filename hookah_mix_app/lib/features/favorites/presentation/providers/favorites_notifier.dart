import 'package:hookah_mix_master/core/services/providers.dart';
import 'package:hookah_mix_master/features/favorites/data/datasources/favorites_datasource.dart';
import 'package:hookah_mix_master/features/favorites/data/repositories/favorites_repository_impl.dart';
import 'package:hookah_mix_master/features/favorites/domain/entities/favorite_entry.dart';
import 'package:hookah_mix_master/features/favorites/domain/repositories/favorites_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'favorites_notifier.g.dart';

@Riverpod(keepAlive: true)
FavoritesRepository favoritesRepository(Ref ref) => FavoritesRepositoryImpl(
  FavoritesDatasource(ref.watch(hiveServiceProvider)),
);

@Riverpod(keepAlive: true)
class FavoritesNotifier extends _$FavoritesNotifier {
  @override
  List<FavoriteEntry> build() =>
      ref.watch(favoritesRepositoryProvider).getFavorites();

  Future<void> toggle(
    FavoriteType type,
    String refId,
    String displayName,
  ) async {
    final repo = ref.read(favoritesRepositoryProvider);
    if (repo.isFavorite(type, refId)) {
      final entry = state.firstWhere((e) => e.type == type && e.refId == refId);
      await repo.removeFavorite(entry.id);
    } else {
      await repo.addFavorite(
        type: type,
        refId: refId,
        displayName: displayName,
      );
    }
    state = ref.read(favoritesRepositoryProvider).getFavorites();
  }

  bool isFavorite(FavoriteType type, String refId) =>
      ref.read(favoritesRepositoryProvider).isFavorite(type, refId);
}
