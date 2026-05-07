import 'package:hookah_mix_master/features/favorites/domain/entities/favorite_entry.dart';

abstract interface class FavoritesRepository {
  List<FavoriteEntry> getFavorites();
  Future<FavoriteEntry> addFavorite({
    required FavoriteType type,
    required String refId,
    required String displayName,
  });
  Future<void> removeFavorite(String id);
  bool isFavorite(FavoriteType type, String refId);
}
