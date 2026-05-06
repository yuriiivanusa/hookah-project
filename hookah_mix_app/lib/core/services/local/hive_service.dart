import 'package:hive_flutter/hive_flutter.dart';
import 'package:hookah_mix_master/core/constants/string_constants.dart';

class HiveService {
  static bool _initialized = false;

  Future<void> init() async {
    if (_initialized) return;
    await Hive.initFlutter();
    await Hive.openBox<String>(StringConstants.tobaccoBoxName);
    await Hive.openBox<String>(StringConstants.userPrefsBoxName);
    _initialized = true;
  }

  Box<String> get tobaccoBox => Hive.box<String>(StringConstants.tobaccoBoxName);
  Box<String> get userPrefsBox => Hive.box<String>(StringConstants.userPrefsBoxName);

  Future<void> put(String boxName, String key, String value) async {
    await Hive.box<String>(boxName).put(key, value);
  }

  String? get(String boxName, String key) {
    return Hive.box<String>(boxName).get(key);
  }

  Future<void> delete(String boxName, String key) async {
    await Hive.box<String>(boxName).delete(key);
  }

  Future<void> clearBox(String boxName) async {
    await Hive.box<String>(boxName).clear();
  }

  bool isCacheValid(String boxName, String timestampKey) {
    final raw = get(boxName, timestampKey);
    if (raw == null) return false;
    final cached = DateTime.tryParse(raw);
    if (cached == null) return false;
    return DateTime.now().difference(cached) < StringConstants.cacheMaxAge;
  }

  Future<void> touchTimestamp(String boxName, String timestampKey) async {
    await put(boxName, timestampKey, DateTime.now().toIso8601String());
  }
}
