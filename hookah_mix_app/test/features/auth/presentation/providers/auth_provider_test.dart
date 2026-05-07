import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hookah_mix_master/features/auth/domain/entities/app_user.dart';
import 'package:hookah_mix_master/features/auth/domain/repositories/auth_repository.dart';
import 'package:hookah_mix_master/features/auth/presentation/providers/auth_provider.dart';
import 'package:hookah_mix_master/features/auth/presentation/providers/auth_state.dart';
import 'package:mocktail/mocktail.dart';

class _MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late _MockAuthRepository mockRepo;
  late ProviderContainer container;

  const testUser = AppUser(id: 'u1', email: 'test@test.com');

  setUp(() {
    mockRepo = _MockAuthRepository();
    when(
      () => mockRepo.authStateChanges,
    ).thenAnswer((_) => const Stream.empty());

    container = ProviderContainer(
      overrides: [authRepositoryProvider.overrideWithValue(mockRepo)],
    );
  });

  tearDown(() => container.dispose());

  test('initial state is AuthState.initial', () {
    expect(container.read(authProvider), isA<AuthStateInitial>());
  });

  test('login transitions to authenticated on success', () async {
    when(
      () => mockRepo.login(
        email: any(named: 'email'),
        password: any(named: 'password'),
      ),
    ).thenAnswer((_) async => testUser);

    await container
        .read(authProvider.notifier)
        .login(email: 'test@test.com', password: 'password123');

    expect(container.read(authProvider), isA<AuthStateAuthenticated>());
    final state = container.read(authProvider) as AuthStateAuthenticated;
    expect(state.user.email, 'test@test.com');
  });

  test('login transitions to error on failure', () async {
    when(
      () => mockRepo.login(
        email: any(named: 'email'),
        password: any(named: 'password'),
      ),
    ).thenThrow(Exception('wrong-password'));

    await container
        .read(authProvider.notifier)
        .login(email: 'test@test.com', password: 'wrong');

    expect(container.read(authProvider), isA<AuthStateError>());
  });

  test('logout transitions to unauthenticated', () async {
    when(() => mockRepo.logout()).thenAnswer((_) async {});

    await container.read(authProvider.notifier).logout();

    expect(container.read(authProvider), isA<AuthStateUnauthenticated>());
  });

  test('guestMode transitions to authenticated with guest user', () async {
    when(() => mockRepo.guestMode()).thenAnswer((_) async => AppUser.guest());

    await container.read(authProvider.notifier).enterGuestMode();

    final state = container.read(authProvider) as AuthStateAuthenticated;
    expect(state.user.isGuest, isTrue);
  });

  test('currentUserProvider returns user when authenticated', () async {
    when(
      () => mockRepo.login(
        email: any(named: 'email'),
        password: any(named: 'password'),
      ),
    ).thenAnswer((_) async => testUser);

    await container
        .read(authProvider.notifier)
        .login(email: 'test@test.com', password: 'password123');

    expect(container.read(currentUserProvider), isA<AppUser>());
  });
}
