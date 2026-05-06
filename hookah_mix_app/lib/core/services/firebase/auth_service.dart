import 'package:firebase_auth/firebase_auth.dart';
import 'package:hookah_mix_master/core/errors/auth_exception.dart';

class AuthService {
  AuthService(this._auth);

  final FirebaseAuth _auth;

  Stream<User?> get authStateChanges => _auth.authStateChanges();
  User? get currentUser => _auth.currentUser;

  Future<User> signIn({required String email, required String password}) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return result.user!;
    } on FirebaseAuthException catch (e) {
      throw _mapError(e);
    }
  }

  Future<User> signUp({required String email, required String password}) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return result.user!;
    } on FirebaseAuthException catch (e) {
      throw _mapError(e);
    }
  }

  Future<void> signOut() => _auth.signOut();

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw _mapError(e);
    }
  }

  AuthException _mapError(FirebaseAuthException e) => switch (e.code) {
    'invalid-email' => AuthException.invalidEmail(),
    'weak-password' => AuthException.weakPassword(),
    'email-already-in-use' => AuthException.emailAlreadyInUse(),
    'user-not-found' => AuthException.userNotFound(),
    'wrong-password' || 'invalid-credential' => AuthException.wrongPassword(),
    'too-many-requests' => AuthException.tooManyRequests(),
    _ => AuthException.unknown(e.message),
  };
}
