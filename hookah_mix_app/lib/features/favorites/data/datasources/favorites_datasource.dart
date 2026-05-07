import 'dart:convert';

import 'package:hookah_mix_master/core/constants/string_constants.dart';
import 'package:hookah_mix_master/core/services/local/hive_service.dart';
import 'package:hookah_mix_master/features/favorites/domain/entities/favorite_entry.dart';

class FavoritesDatasource {
  FavoritesDatasource(this._hive);

  final HiveService _hive;

  static const _box = StringConstants.userPrefsBoxName;
  static const _key = 'favorites';

  List<FavoriteEntry> getFavorites() {
    final raw = _hive.get(_box, _key);
    if (raw == null) return [];
    final list = jsonDecode(raw) as List<dynamic>;
    return list.map((e) => _fromJson(e as Map<String, dynamic>)).toList()
      ..sort((a, b) => b.addedAt.compareTo(a.addedAt));
  }

  Future<FavoriteEntry> addFavorite(FavoriteEntry entry) async {
    final all = getFavorites()..add(entry);
    await _saveAll(all);
    return entry;
  }

  Future<void> removeFavorite(String id) async {
    final all = getFavorites().where((e) => e.id != id).toList();
    await _saveAll(all);
  }

  bool isFavorite(FavoriteType type, String refId) =>
      getFavorites().any((e) => e.type == type && e.refId == refId);

  Future<void> _saveAll(List<FavoriteEntry> entries) async {
    await _hive.put(_box, _key, jsonEncode(entries.map(_toJson).toList()));
  }

  Map<String, dynamic> _toJson(FavoriteEntry e) => {
    'id': e.id,
    'type': e.type.name,
    'refId': e.refId,
    'displayName': e.displayName,
    'addedAt': e.addedAt.toIso8601String(),
  };

  FavoriteEntry _fromJson(Map<String, dynamic> map) => FavoriteEntry(
    id: map['id'] as String,
    type: FavoriteType.values.byName(map['type'] as String),
    refId: map['refId'] as String,
    displayName: map['displayName'] as String,
    addedAt: DateTime.parse(map['addedAt'] as String),
  );
}
