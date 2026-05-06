import 'dart:convert';

import 'package:hookah_mix_master/core/constants/string_constants.dart';
import 'package:hookah_mix_master/core/services/local/hive_service.dart';
import 'package:hookah_mix_master/features/tobacco_catalog/data/dtos/brand_dto.dart';
import 'package:hookah_mix_master/features/tobacco_catalog/data/dtos/tobacco_dto.dart';

class TobaccoLocalDataSource {
  TobaccoLocalDataSource(this._hive);

  final HiveService _hive;

  static const _boxName = StringConstants.tobaccoBoxName;
  static const _tobaccosKey = 'tobaccos_data';
  static const _brandsKey = 'brands_data';
  static const _versionKey = 'catalog_version';
  static const _timestampKey = 'catalog_timestamp';

  Future<void> cacheTobaccos(
    List<TobaccoDto> tobaccos,
    List<BrandDto> brands,
    String version,
  ) async {
    await _hive.put(_boxName, _tobaccosKey, jsonEncode(tobaccos.map((t) => t.toJson()).toList()));
    await _hive.put(_boxName, _brandsKey, jsonEncode(brands.map((b) => b.toJson()).toList()));
    await _hive.put(_boxName, _versionKey, version);
    await _hive.touchTimestamp(_boxName, _timestampKey);
  }

  List<TobaccoDto>? getCachedTobaccos() {
    final raw = _hive.get(_boxName, _tobaccosKey);
    if (raw == null) return null;
    final list = jsonDecode(raw) as List<dynamic>;
    return list.map((e) => TobaccoDto.fromJson(e as Map<String, dynamic>)).toList();
  }

  List<BrandDto>? getCachedBrands() {
    final raw = _hive.get(_boxName, _brandsKey);
    if (raw == null) return null;
    final list = jsonDecode(raw) as List<dynamic>;
    return list.map((e) => BrandDto.fromJson(e as Map<String, dynamic>)).toList();
  }

  bool isCacheValid() => _hive.isCacheValid(_boxName, _timestampKey);

  String? getCachedVersion() => _hive.get(_boxName, _versionKey);

  Future<void> clearCache() => _hive.clearBox(_boxName);
}
