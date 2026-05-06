import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hookah_mix_master/core/constants/string_constants.dart';

class SecureStorageService {
  SecureStorageService(this._storage);

  final FlutterSecureStorage _storage;

  Future<void> writeAuthToken(String token) =>
      _storage.write(key: StringConstants.authTokenKey, value: token);

  Future<String?> readAuthToken() =>
      _storage.read(key: StringConstants.authTokenKey);

  Future<void> deleteAuthToken() =>
      _storage.delete(key: StringConstants.authTokenKey);

  Future<void> write(String key, String value) => _storage.write(key: key, value: value);
  Future<String?> read(String key) => _storage.read(key: key);
  Future<void> delete(String key) => _storage.delete(key: key);
  Future<void> deleteAll() => _storage.deleteAll();
}
