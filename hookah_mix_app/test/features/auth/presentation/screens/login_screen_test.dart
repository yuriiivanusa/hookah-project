import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:hookah_mix_master/features/auth/domain/entities/app_user.dart';
import 'package:hookah_mix_master/features/auth/domain/repositories/auth_repository.dart';
import 'package:hookah_mix_master/features/auth/presentation/providers/auth_provider.dart';
import 'package:hookah_mix_master/features/auth/presentation/screens/login_screen.dart';
import 'package:hookah_mix_master/l10n/app_localizations.dart';
import 'package:mocktail/mocktail.dart';

class _MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late _MockAuthRepository mockRepo;

  setUp(() {
    mockRepo = _MockAuthRepository();
    when(
      () => mockRepo.authStateChanges,
    ).thenAnswer((_) => const Stream.empty());
  });

  Widget buildApp() => ProviderScope(
    overrides: [authRepositoryProvider.overrideWithValue(mockRepo)],
    child: MaterialApp.router(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: GoRouter(
        initialLocation: '/login',
        routes: [
          GoRoute(
            path: '/login',
            builder: (context, state) => const LoginScreen(),
          ),
          GoRoute(
            path: '/signup',
            builder: (context, state) => const SizedBox(),
          ),
          GoRoute(
            path: '/forgot-password',
            builder: (context, state) => const SizedBox(),
          ),
          GoRoute(
            path: '/catalog',
            builder: (context, state) => const Text('Catalog'),
          ),
        ],
      ),
    ),
  );

  testWidgets('renders email and password fields', (tester) async {
    await tester.pumpWidget(buildApp());
    await tester.pumpAndSettle();

    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.byType(ElevatedButton), findsOneWidget);
  });

  testWidgets('submit with empty fields shows validation errors', (
    tester,
  ) async {
    await tester.pumpWidget(buildApp());
    await tester.pumpAndSettle();

    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    expect(find.text('Email is required'), findsOneWidget);
  });

  testWidgets('shows loading indicator while signing in', (tester) async {
    final completer = Completer<AppUser>();
    when(
      () => mockRepo.login(
        email: any(named: 'email'),
        password: any(named: 'password'),
      ),
    ).thenAnswer((_) => completer.future);

    await tester.pumpWidget(buildApp());
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextFormField).at(0), 'test@test.com');
    await tester.enterText(find.byType(TextFormField).at(1), 'password123');

    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    completer.complete(const AppUser(id: 'u1', email: 'test@test.com'));
    await tester.pumpAndSettle();
  });

  testWidgets('shows snackbar on login error', (tester) async {
    when(
      () => mockRepo.login(
        email: any(named: 'email'),
        password: any(named: 'password'),
      ),
    ).thenThrow(Exception('wrong-password'));

    await tester.pumpWidget(buildApp());
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextFormField).at(0), 'test@test.com');
    await tester.enterText(find.byType(TextFormField).at(1), 'wrongpass1');

    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    expect(find.byType(SnackBar), findsOneWidget);
  });
}
