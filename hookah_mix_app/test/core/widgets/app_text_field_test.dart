import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hookah_mix_master/core/widgets/app_text_field.dart';

void main() {
  Widget wrap(Widget child) => MaterialApp(
        home: Scaffold(body: Form(child: child)),
      );

  testWidgets('displays label', (tester) async {
    await tester.pumpWidget(wrap(const AppTextField(label: 'Email')));
    expect(find.text('Email'), findsOneWidget);
  });

  testWidgets('shows validation error', (tester) async {
    final key = GlobalKey<FormState>();
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Form(
          key: key,
          child: AppTextField(
            label: 'Email',
            validator: (v) => v!.isEmpty ? 'Required' : null,
          ),
        ),
      ),
    ));
    key.currentState!.validate();
    await tester.pump();
    expect(find.text('Required'), findsOneWidget);
  });

  testWidgets('password field shows visibility toggle', (tester) async {
    await tester.pumpWidget(wrap(const AppTextField(label: 'Password', isPassword: true)));
    expect(find.byIcon(Icons.visibility_off), findsOneWidget);
    await tester.tap(find.byIcon(Icons.visibility_off));
    await tester.pump();
    expect(find.byIcon(Icons.visibility), findsOneWidget);
  });
}
