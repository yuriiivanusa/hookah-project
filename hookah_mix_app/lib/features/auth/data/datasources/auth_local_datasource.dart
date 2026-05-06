import 'dart:convert';
import 'package:hookah_mix_master/core/services/local/secure_storage_service.dart';
import 'package:hookah_mix_master/features/auth/data/dtos/user_dto.dart';

class AuthLocalDataSource {
  AuthLocalDataSource(this._secureStorage);

  final SecureStorageService _secureStorage;

  static const _userKey = 'cached_user';

  Future<void> cacheUser(UserDto user) =>
      _secureStorage.write(_userKey, jsonEncode(user.toJson()));

  Future<UserDto?> getCachedUser() async {
    final raw = await _secureStorage.read(_userKey);
    if (raw == null) return null;
    return UserDto.fromJson(jsonDecode(raw) as Map<String, dynamic>);
  }

  Future<void> clearUser() => _secureStorage.delete(_userKey);
}
