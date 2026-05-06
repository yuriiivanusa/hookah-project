import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hookah_mix_master/core/errors/auth_exception.dart';
import 'package:hookah_mix_master/features/auth/data/dtos/user_dto.dart';

class AuthRemoteDataSource {
  AuthRemoteDataSource(this._auth, this._googleSignIn);

  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;

  Stream<User?> get authStateChanges => _auth.authStateChanges();
  User? get currentFirebaseUser => _auth.currentUser;

  Future<UserDto> signInWithEmail(String email, String password) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return _toDto(result.user!);
    } on FirebaseAuthException catch (e) {
      throw _mapError(e);
    }
  }

  Future<UserDto> createUserWithEmail(
    String email,
    String password,
    String displayName,
  ) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await result.user!.updateDisplayName(displayName);
      await result.user!.sendEmailVerification();
      return _toDto(result.user!..reload());
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

  Future<void> sendEmailVerification() async {
    final user = _auth.currentUser;
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
    }
  }

  Future<UserDto> signInWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        throw AuthException.unknown('Google sign in cancelled');
      }
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final result = await _auth.signInWithCredential(credential);
      return _toDto(result.user!);
    } on FirebaseAuthException catch (e) {
      throw _mapError(e);
    }
  }

  Future<void> deleteAccount() async {
    final user = _auth.currentUser;
    if (user == null) throw AuthException.unknown('No user to delete');
    try {
      await user.delete();
    } on FirebaseAuthException catch (e) {
      throw _mapError(e);
    }
  }

  UserDto _toDto(User user) => UserDto.fromFirebaseUser(
    user.uid,
    user.email ?? '',
    displayName: user.displayName,
    photoUrl: user.photoURL,
    isEmailVerified: user.emailVerified,
  );

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
