import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hookah_mix_master/core/widgets/app_button.dart';

void main() {
  Widget wrap(Widget child) => MaterialApp(home: Scaffold(body: child));

  testWidgets('renders label', (tester) async {
    await tester.pumpWidget(wrap(AppButton(label: 'Submit', onPressed: () {})));
    expect(find.text('Submit'), findsOneWidget);
  });

  testWidgets('calls onPressed when tapped', (tester) async {
    var pressed = false;
    await tester.pumpWidget(wrap(AppButton(label: 'Tap', onPressed: () => pressed = true)));
    await tester.tap(find.text('Tap'));
    expect(pressed, isTrue);
  });

  testWidgets('disabled when isLoading is true', (tester) async {
    var pressed = false;
    await tester.pumpWidget(
      wrap(AppButton(label: 'Loading', onPressed: () => pressed = true, isLoading: true)),
    );
    await tester.tap(find.byType(ElevatedButton));
    expect(pressed, isFalse);
  });

  testWidgets('outlined variant renders OutlinedButton', (tester) async {
    await tester.pumpWidget(
      wrap(AppButton(label: 'Outlined', onPressed: () {}, variant: AppButtonVariant.outlined)),
    );
    expect(find.byType(OutlinedButton), findsOneWidget);
  });
}
