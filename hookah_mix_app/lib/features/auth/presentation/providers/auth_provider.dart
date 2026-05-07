import 'package:hookah_mix_master/core/services/providers.dart';
import 'package:hookah_mix_master/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:hookah_mix_master/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:hookah_mix_master/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:hookah_mix_master/features/auth/domain/entities/app_user.dart';
import 'package:hookah_mix_master/features/auth/domain/repositories/auth_repository.dart';
import 'package:hookah_mix_master/features/auth/presentation/providers/auth_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_provider.g.dart';

@riverpod
class Auth extends _$Auth {
  AuthRepository get _repo => ref.read(authRepositoryProvider);

  @override
  AuthState build() {
    ref.listen(authRepositoryProvider, (_, repo) {
      repo.authStateChanges.listen((user) {
        state = user != null
            ? AuthState.authenticated(user)
            : const AuthState.unauthenticated();
      });
    });
    return const AuthState.initial();
  }

  Future<void> login({required String email, required String password}) async {
    state = const AuthState.loading();
    try {
      final user = await _repo.login(email: email, password: password);
      state = AuthState.authenticated(user);
    } on Exception catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  Future<void> signup({
    required String email,
    required String password,
    required String displayName,
    required DateTime dateOfBirth,
  }) async {
    state = const AuthState.loading();
    try {
      final user = await _repo.signup(
        email: email,
        password: password,
        displayName: displayName,
        dateOfBirth: dateOfBirth,
      );
      state = AuthState.authenticated(user);
    } on Exception catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  Future<void> logout() async {
    state = const AuthState.loading();
    try {
      await _repo.logout();
      state = const AuthState.unauthenticated();
    } on Exception catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  Future<void> signInWithGoogle() async {
    state = const AuthState.loading();
    try {
      final user = await _repo.signInWithGoogle();
      state = AuthState.authenticated(user);
    } on Exception catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  Future<void> signInWithApple() async {
    state = const AuthState.loading();
    try {
      final user = await _repo.signInWithApple();
      state = AuthState.authenticated(user);
    } on Exception catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  Future<void> resetPassword(String email) async {
    state = const AuthState.loading();
    try {
      await _repo.resetPassword(email);
      state = const AuthState.unauthenticated();
    } on Exception catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  Future<void> enterGuestMode() async {
    state = const AuthState.loading();
    try {
      final user = await _repo.guestMode();
      state = AuthState.authenticated(user);
    } on Exception catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  Future<void> deleteAccount() async {
    state = const AuthState.loading();
    try {
      await _repo.deleteAccount();
      state = const AuthState.unauthenticated();
    } on Exception catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  AppUser? get currentUser => switch (state) {
    AuthStateAuthenticated(:final user) => user,
    _ => null,
  };
}

@Riverpod(keepAlive: true)
AuthRepository authRepository(Ref ref) {
  final remote = AuthRemoteDataSource(
    ref.watch(firebaseAuthProvider),
    ref.watch(googleSignInProvider),
  );
  final local = AuthLocalDataSource(ref.watch(secureStorageProvider));
  return AuthRepositoryImpl(remote, local);
}

@riverpod
AppUser? currentUser(Ref ref) {
  final authState = ref.watch(authProvider);
  return switch (authState) {
    AuthStateAuthenticated(:final user) => user,
    _ => null,
  };
}

@riverpod
bool isGuest(Ref ref) => ref.watch(currentUserProvider)?.isGuest ?? false;
