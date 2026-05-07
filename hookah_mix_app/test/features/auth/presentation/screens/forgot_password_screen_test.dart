import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:hookah_mix_master/features/auth/domain/repositories/auth_repository.dart';
import 'package:hookah_mix_master/features/auth/presentation/providers/auth_provider.dart';
import 'package:hookah_mix_master/features/auth/presentation/screens/forgot_password_screen.dart';
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
    when(() => mockRepo.resetPassword(any())).thenAnswer((_) async {});
  });

  Widget buildApp() => ProviderScope(
    overrides: [authRepositoryProvider.overrideWithValue(mockRepo)],
    child: MaterialApp.router(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: GoRouter(
        initialLocation: '/forgot-password',
        routes: [
          GoRoute(
            path: '/forgot-password',
            builder: (context, state) => const ForgotPasswordScreen(),
          ),
        ],
      ),
    ),
  );

  testWidgets('renders email field and send button', (tester) async {
    await tester.pumpWidget(buildApp());
    await tester.pumpAndSettle();

    expect(find.byType(TextFormField), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);
  });

  testWidgets('submit with empty email shows validation error', (tester) async {
    await tester.pumpWidget(buildApp());
    await tester.pumpAndSettle();

    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    expect(find.text('Email is required'), findsOneWidget);
  });

  testWidgets('submit with valid email shows success message', (tester) async {
    await tester.pumpWidget(buildApp());
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextFormField), 'test@test.com');
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.mark_email_read_outlined), findsOneWidget);
  });
}
