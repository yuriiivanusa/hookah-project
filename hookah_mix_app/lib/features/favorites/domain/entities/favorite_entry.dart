import 'package:freezed_annotation/freezed_annotation.dart';

part 'favorite_entry.freezed.dart';

enum FavoriteType { tobacco, mix }

@freezed
abstract class FavoriteEntry with _$FavoriteEntry {
  const factory FavoriteEntry({
    required String id,
    required FavoriteType type,
    required String refId,
    required String displayName,
    required DateTime addedAt,
  }) = _FavoriteEntry;
}
