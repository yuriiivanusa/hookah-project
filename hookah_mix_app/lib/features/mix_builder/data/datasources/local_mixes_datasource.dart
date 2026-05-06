import 'dart:convert';

import 'package:hookah_mix_master/core/constants/string_constants.dart';
import 'package:hookah_mix_master/core/services/local/hive_service.dart';
import 'package:hookah_mix_master/features/mix_builder/data/dtos/user_mix_dto.dart';
import 'package:hookah_mix_master/features/mix_builder/domain/entities/user_mix.dart';

class LocalMixesDatasource {
  LocalMixesDatasource(this._hive);

  final HiveService _hive;

  static const _box = StringConstants.userMixesBoxName;
  static const _key = 'mixes';

  List<UserMix> getUserMixes() {
    final raw = _hive.get(_box, _key);
    if (raw == null) return [];
    final list = jsonDecode(raw) as List<dynamic>;
    return list.map((e) => _fromJson(e as Map<String, dynamic>)).whereType<UserMix>().toList()
      ..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
  }

  Future<UserMix> createMix(UserMix mix) async {
    final id = DateTime.now().millisecondsSinceEpoch.toString();
    final now = DateTime.now();
    final withId = mix.copyWith(id: id, createdAt: now, updatedAt: now);
    final mixes = getUserMixes()..add(withId);
    await _saveAll(mixes);
    return withId;
  }

  Future<UserMix> updateMix(UserMix mix) async {
    final updated = mix.copyWith(updatedAt: DateTime.now());
    final mixes = getUserMixes().map((m) => m.id == mix.id ? updated : m).toList();
    await _saveAll(mixes);
    return updated;
  }

  Future<void> deleteMix(String mixId) async {
    final mixes = getUserMixes().where((m) => m.id != mixId).toList();
    await _saveAll(mixes);
  }

  // ── private ───────────────────────────────────────────────────────────────

  Future<void> _saveAll(List<UserMix> mixes) async {
    final encoded = jsonEncode(mixes.map(_toJson).toList());
    await _hive.put(_box, _key, encoded);
  }

  Map<String, dynamic> _toJson(UserMix mix) => {
    'id': mix.id,
    'userId': mix.userId,
    'name': mix.name,
    'description': mix.description,
    'components': mix.components.map((c) => MixComponentDto.fromDomain(c).toJson()).toList(),
    'tasteProfile': mix.tasteProfile != null
        ? TasteProfileDto3.fromDomain(mix.tasteProfile!).toJson()
        : null,
    'rating': mix.rating,
    'createdAt': mix.createdAt.toIso8601String(),
    'updatedAt': mix.updatedAt.toIso8601String(),
  };

  UserMix? _fromJson(Map<String, dynamic> map) {
    try {
      final components = (map['components'] as List<dynamic>)
          .map((e) => MixComponentDto.fromJson(e as Map<String, dynamic>).toDomain())
          .toList();
      final tp = map['tasteProfile'] != null
          ? TasteProfileDto3.fromJson(map['tasteProfile'] as Map<String, dynamic>).toDomain()
          : null;
      return UserMix(
        id: map['id'] as String,
        userId: map['userId'] as String? ?? '',
        name: map['name'] as String,
        description: map['description'] as String? ?? '',
        components: components,
        tasteProfile: tp,
        rating: map['rating'] as int? ?? 0,
        createdAt: DateTime.parse(map['createdAt'] as String),
        updatedAt: DateTime.parse(map['updatedAt'] as String),
      );
    } catch (_) {
      return null;
    }
  }
}
