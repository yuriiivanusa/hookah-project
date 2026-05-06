import 'package:flutter_test/flutter_test.dart';
import 'package:hookah_mix_master/core/router/auth_guard.dart';
import 'package:hookah_mix_master/core/router/routes.dart';

void main() {
  String? guard({required bool isLoggedIn, required String location}) =>
      authGuard(isLoggedIn: isLoggedIn, matchedLocation: location);

  test('unauthenticated user on protected route redirects to login', () {
    expect(guard(isLoggedIn: false, location: Routes.catalog), Routes.login);
  });

  test('authenticated user on login page redirects to catalog', () {
    expect(guard(isLoggedIn: true, location: Routes.login), Routes.catalog);
  });

  test('unauthenticated user on login stays (returns null)', () {
    expect(guard(isLoggedIn: false, location: Routes.login), isNull);
  });

  test('authenticated user on catalog stays (returns null)', () {
    expect(guard(isLoggedIn: true, location: Routes.catalog), isNull);
  });

  test('unauthenticated user on signup stays (returns null)', () {
    expect(guard(isLoggedIn: false, location: Routes.signup), isNull);
  });
}
