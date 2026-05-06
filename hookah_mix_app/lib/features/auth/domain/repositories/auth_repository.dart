import 'package:hookah_mix_master/features/auth/domain/entities/app_user.dart';

abstract interface class AuthRepository {
  Stream<AppUser?> get authStateChanges;
  AppUser? get currentUser;

  Future<AppUser> login({required String email, required String password});
  Future<AppUser> signup({
    required String email,
    required String password,
    required String displayName,
    required DateTime dateOfBirth,
  });
  Future<void> logout();
  Future<AppUser?> getCurrentUser();
  Future<void> resetPassword(String email);
  Future<void> verifyEmail();
  Future<AppUser> signInWithGoogle();
  Future<AppUser> signInWithApple();
  Future<void> deleteAccount();
  Future<AppUser> guestMode();
}
