import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hookah_mix_master/core/widgets/empty_state.dart';

void main() {
  Widget wrap(Widget child) => MaterialApp(home: Scaffold(body: child));

  testWidgets('displays message', (tester) async {
    await tester.pumpWidget(wrap(const EmptyState(message: 'No items found')));
    expect(find.text('No items found'), findsOneWidget);
  });

  testWidgets('shows action button when provided', (tester) async {
    var tapped = false;
    await tester.pumpWidget(
      wrap(
        EmptyState(
          message: 'Empty',
          action: () => tapped = true,
          actionLabel: 'Add',
        ),
      ),
    );
    expect(find.text('Add'), findsOneWidget);
    await tester.tap(find.text('Add'));
    expect(tapped, isTrue);
  });

  testWidgets('hides action button when not provided', (tester) async {
    await tester.pumpWidget(wrap(const EmptyState(message: 'Empty')));
    expect(find.byType(ElevatedButton), findsNothing);
  });
}
