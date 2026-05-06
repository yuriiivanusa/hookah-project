import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hookah_mix_master/core/errors/auth_exception.dart';
import 'package:hookah_mix_master/core/services/local/secure_storage_service.dart';
import 'package:hookah_mix_master/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:hookah_mix_master/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:hookah_mix_master/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:hookah_mix_master/features/auth/domain/entities/app_user.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class _MockGoogleSignIn extends Mock implements GoogleSignIn {}

class _MockSecureStorage extends Mock implements FlutterSecureStorage {}

void main() {
  late MockFirebaseAuth mockAuth;
  late _MockGoogleSignIn mockGoogle;
  late _MockSecureStorage mockFlutterStorage;
  late AuthRemoteDataSource remote;
  late AuthLocalDataSource local;
  late AuthRepositoryImpl sut;

  setUp(() {
    mockAuth = MockFirebaseAuth(mockUser: MockUser(email: 'test@test.com'));
    mockGoogle = _MockGoogleSignIn();
    mockFlutterStorage = _MockSecureStorage();
    remote = AuthRemoteDataSource(mockAuth, mockGoogle);
    local = AuthLocalDataSource(SecureStorageService(mockFlutterStorage));
    sut = AuthRepositoryImpl(remote, local);

    when(
      () => mockFlutterStorage.write(
        key: any(named: 'key'),
        value: any(named: 'value'),
      ),
    ).thenAnswer((_) async {});
    when(() => mockFlutterStorage.read(key: any(named: 'key'))).thenAnswer((_) async => null);
    when(() => mockFlutterStorage.delete(key: any(named: 'key'))).thenAnswer((_) async {});
  });

  group('login', () {
    test('returns AppUser on success', () async {
      final user = await sut.login(email: 'test@test.com', password: 'password123');
      expect(user, isA<AppUser>());
      expect(user.email, 'test@test.com');
    });
  });

  group('signup', () {
    test('throws AuthException for under-18 user', () async {
      expect(
        () => sut.signup(
          email: 'teen@test.com',
          password: 'password123',
          displayName: 'Teen',
          dateOfBirth: DateTime.now().subtract(const Duration(days: 365 * 16)),
        ),
        throwsA(isA<AuthException>()),
      );
    });

    test('succeeds for 18+ user', () async {
      final user = await sut.signup(
        email: 'adult@test.com',
        password: 'password123',
        displayName: 'Adult',
        dateOfBirth: DateTime.now().subtract(const Duration(days: 365 * 25)),
      );
      expect(user, isA<AppUser>());
    });
  });

  group('logout', () {
    test('clears local storage', () async {
      await sut.logout();
      verify(() => mockFlutterStorage.delete(key: any(named: 'key'))).called(greaterThan(0));
    });
  });

  group('guestMode', () {
    test('returns guest user', () async {
      final user = await sut.guestMode();
      expect(user.isGuest, isTrue);
      expect(user.id, 'guest');
    });
  });

  group('resetPassword', () {
    test('calls remote datasource', () async {
      await expectLater(sut.resetPassword('test@test.com'), completes);
    });
  });
}
