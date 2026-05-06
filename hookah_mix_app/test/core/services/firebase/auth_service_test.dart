import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hookah_mix_master/core/errors/auth_exception.dart';
import 'package:hookah_mix_master/core/services/firebase/auth_service.dart';

void main() {
  late MockFirebaseAuth mockAuth;
  late AuthService sut;

  setUp(() {
    mockAuth = MockFirebaseAuth();
    sut = AuthService(mockAuth);
  });

  group('AuthService.signIn', () {
    test('returns user on success', () async {
      final auth = MockFirebaseAuth(signedIn: false);
      final service = AuthService(auth);
      final user = await service.signIn(email: 'test@test.com', password: 'password123');
      expect(user, isNotNull);
    });
  });

  group('AuthService.signOut', () {
    test('signs out successfully', () async {
      final auth = MockFirebaseAuth(signedIn: true);
      final service = AuthService(auth);
      await service.signOut();
      expect(service.currentUser, isNull);
    });
  });

  group('AuthService.authStateChanges', () {
    test('emits stream', () {
      expect(sut.authStateChanges, isA<Stream>());
    });
  });

  group('AuthException mapping', () {
    test('maps unknown error to AuthException.unknown', () {
      final e = AuthException.unknown('test');
      expect(e.code, 'unknown');
      expect(e.message, 'test');
    });
  });
}
