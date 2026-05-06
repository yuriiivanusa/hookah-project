import 'package:hookah_mix_master/core/errors/auth_exception.dart';
import 'package:hookah_mix_master/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:hookah_mix_master/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:hookah_mix_master/features/auth/data/dtos/user_dto.dart';
import 'package:hookah_mix_master/features/auth/domain/entities/app_user.dart';
import 'package:hookah_mix_master/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._remote, this._local);

  final AuthRemoteDataSource _remote;
  final AuthLocalDataSource _local;

  static const _minAgeYears = 18;

  @override
  Stream<AppUser?> get authStateChanges => _remote.authStateChanges.asyncMap((user) async {
    if (user == null) return null;
    final dto = UserDto.fromFirebaseUser(
      user.uid,
      user.email ?? '',
      displayName: user.displayName,
      photoUrl: user.photoURL,
      isEmailVerified: user.emailVerified,
    );
    await _local.cacheUser(dto);
    return dto.toDomain();
  });

  @override
  AppUser? get currentUser {
    final user = _remote.currentFirebaseUser;
    if (user == null) return null;
    return UserDto.fromFirebaseUser(
      user.uid,
      user.email ?? '',
      displayName: user.displayName,
      photoUrl: user.photoURL,
    ).toDomain();
  }

  @override
  Future<AppUser> login({required String email, required String password}) async {
    final dto = await _remote.signInWithEmail(email, password);
    await _local.cacheUser(dto);
    return dto.toDomain();
  }

  @override
  Future<AppUser> signup({
    required String email,
    required String password,
    required String displayName,
    required DateTime dateOfBirth,
  }) async {
    _verifyAge(dateOfBirth);
    final dto = await _remote.createUserWithEmail(email, password, displayName);
    await _local.cacheUser(dto);
    return dto.toDomain();
  }

  @override
  Future<void> logout() async {
    await _remote.signOut();
    await _local.clearUser();
  }

  @override
  Future<AppUser?> getCurrentUser() async {
    final firebaseUser = _remote.currentFirebaseUser;
    if (firebaseUser != null) {
      final dto = UserDto.fromFirebaseUser(
        firebaseUser.uid,
        firebaseUser.email ?? '',
        displayName: firebaseUser.displayName,
        isEmailVerified: firebaseUser.emailVerified,
      );
      return dto.toDomain();
    }
    final cached = await _local.getCachedUser();
    return cached?.toDomain();
  }

  @override
  Future<void> resetPassword(String email) => _remote.sendPasswordResetEmail(email);

  @override
  Future<void> verifyEmail() => _remote.sendEmailVerification();

  @override
  Future<AppUser> signInWithGoogle() async {
    final dto = await _remote.signInWithGoogle();
    await _local.cacheUser(dto);
    return dto.toDomain();
  }

  @override
  Future<AppUser> signInWithApple() async {
    // Apple Sign In not yet implemented — requires native entitlements
    throw AuthException.unknown('Apple Sign In coming soon');
  }

  @override
  Future<void> deleteAccount() async {
    await _remote.deleteAccount();
    await _local.clearUser();
  }

  @override
  Future<AppUser> guestMode() async => AppUser.guest();

  void _verifyAge(DateTime dateOfBirth) {
    final age = DateTime.now().difference(dateOfBirth).inDays ~/ 365;
    if (age < _minAgeYears) {
      throw AuthException(message: 'You must be $_minAgeYears or older', code: 'under-age');
    }
  }
}
