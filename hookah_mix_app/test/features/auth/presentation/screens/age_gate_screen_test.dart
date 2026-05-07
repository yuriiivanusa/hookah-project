import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:hookah_mix_master/features/auth/presentation/screens/age_gate_screen.dart';
import 'package:hookah_mix_master/l10n/app_localizations.dart';

void main() {
  Widget buildApp() => MaterialApp.router(
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    routerConfig: GoRouter(
      initialLocation: '/age-gate',
      routes: [
        GoRoute(
          path: '/age-gate',
          builder: (context, state) => const AgeGateScreen(),
        ),
        GoRoute(
          path: '/login',
          builder: (context, state) => const Text('Login Screen'),
        ),
      ],
    ),
  );

  testWidgets('renders confirm and deny buttons', (tester) async {
    await tester.pumpWidget(buildApp());
    await tester.pumpAndSettle();

    expect(find.text('I am 18 or older'), findsOneWidget);
    expect(find.text('I am under 18'), findsOneWidget);
  });

  testWidgets('confirm button navigates to login', (tester) async {
    await tester.pumpWidget(buildApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('I am 18 or older'));
    await tester.pumpAndSettle();

    expect(find.text('Login Screen'), findsOneWidget);
  });

  testWidgets('deny button shows blocked dialog', (tester) async {
    await tester.pumpWidget(buildApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('I am under 18'));
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsOneWidget);
  });

  testWidgets('dialog closes on close button tap', (tester) async {
    await tester.pumpWidget(buildApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('I am under 18'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Close'));
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsNothing);
  });
}
