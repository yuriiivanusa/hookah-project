import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hookah_mix_master/core/widgets/error_view.dart';
import 'package:hookah_mix_master/l10n/app_localizations.dart';

void main() {
  Widget wrap(Widget child) => MaterialApp(
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: Scaffold(body: child),
  );

  testWidgets('displays error message', (tester) async {
    await tester.pumpWidget(
      wrap(const ErrorView(message: 'Something went wrong')),
    );
    expect(find.text('Something went wrong'), findsOneWidget);
    expect(find.byIcon(Icons.error_outline), findsOneWidget);
  });

  testWidgets('shows retry button when onRetry provided', (tester) async {
    var retried = false;
    await tester.pumpWidget(
      wrap(ErrorView(message: 'Error', onRetry: () => retried = true)),
    );
    expect(find.text('Retry'), findsOneWidget);
    await tester.tap(find.text('Retry'));
    expect(retried, isTrue);
  });

  testWidgets('hides retry button when onRetry is null', (tester) async {
    await tester.pumpWidget(wrap(const ErrorView(message: 'Error')));
    expect(find.text('Retry'), findsNothing);
  });
}
