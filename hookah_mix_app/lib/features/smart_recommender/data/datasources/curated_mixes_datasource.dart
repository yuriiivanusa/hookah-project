import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hookah_mix_master/core/constants/string_constants.dart';
import 'package:hookah_mix_master/core/services/local/hive_service.dart';
import 'package:hookah_mix_master/features/smart_recommender/data/dtos/curated_mix_dto.dart';

class CuratedMixesDatasource {
  CuratedMixesDatasource(this._firestore, this._hive);

  final FirebaseFirestore _firestore;
  final HiveService _hive;

  static const _boxName = StringConstants.mixesBoxName;
  static const _mixesKey = 'curated_mixes_data';
  static const _timestampKey = 'curated_mixes_timestamp';

  Future<List<CuratedMixDto>> getCuratedMixes() async {
    if (_hive.isCacheValid(_boxName, _timestampKey)) {
      final cached = _getCached();
      if (cached != null) return cached;
    }
    return _fetchAndCache();
  }

  List<CuratedMixDto>? _getCached() {
    final raw = _hive.get(_boxName, _mixesKey);
    if (raw == null) return null;
    final list = jsonDecode(raw) as List<dynamic>;
    return list.map((e) => CuratedMixDto.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<List<CuratedMixDto>> _fetchAndCache() async {
    final snapshot = await _firestore.collection('curated_mixes').get();
    final dtos = snapshot.docs
        .map((doc) => CuratedMixDto.fromFirestore(doc.id, doc.data()))
        .toList();
    await _hive.put(_boxName, _mixesKey, jsonEncode(dtos.map((d) => d.toJson()).toList()));
    await _hive.touchTimestamp(_boxName, _timestampKey);
    return dtos;
  }
}
