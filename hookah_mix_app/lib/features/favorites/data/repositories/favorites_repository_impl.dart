import 'package:hookah_mix_master/features/favorites/data/datasources/favorites_datasource.dart';
import 'package:hookah_mix_master/features/favorites/domain/entities/favorite_entry.dart';
import 'package:hookah_mix_master/features/favorites/domain/repositories/favorites_repository.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  FavoritesRepositoryImpl(this._datasource);

  final FavoritesDatasource _datasource;

  @override
  List<FavoriteEntry> getFavorites() => _datasource.getFavorites();

  @override
  Future<FavoriteEntry> addFavorite({
    required FavoriteType type,
    required String refId,
    required String displayName,
  }) {
    if (_datasource.isFavorite(type, refId)) {
      return Future.value(
        _datasource.getFavorites().firstWhere(
          (e) => e.type == type && e.refId == refId,
        ),
      );
    }
    final entry = FavoriteEntry(
      id: '${type.name}_$refId',
      type: type,
      refId: refId,
      displayName: displayName,
      addedAt: DateTime.now(),
    );
    return _datasource.addFavorite(entry);
  }

  @override
  Future<void> removeFavorite(String id) => _datasource.removeFavorite(id);

  @override
  bool isFavorite(FavoriteType type, String refId) =>
      _datasource.isFavorite(type, refId);
}
