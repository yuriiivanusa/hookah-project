import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hookah_mix_master/core/providers/locale_provider.dart';
import 'package:hookah_mix_master/core/providers/theme_provider.dart';

ProviderContainer _makeContainer() => ProviderContainer();

void main() {
  group('ThemeMode\$ provider', () {
    test('initial state is dark', () {
      final c = _makeContainer();
      addTearDown(c.dispose);
      expect(c.read(themeMode$Provider), ThemeMode.dark);
    });

    test('setLight changes state to light', () {
      final c = _makeContainer();
      addTearDown(c.dispose);
      c.read(themeMode$Provider.notifier).setLight();
      expect(c.read(themeMode$Provider), ThemeMode.light);
    });

    test('setDark changes state to dark', () {
      final c = _makeContainer();
      addTearDown(c.dispose);
      c.read(themeMode$Provider.notifier).setLight();
      c.read(themeMode$Provider.notifier).setDark();
      expect(c.read(themeMode$Provider), ThemeMode.dark);
    });

    test('setSystem changes state to system', () {
      final c = _makeContainer();
      addTearDown(c.dispose);
      c.read(themeMode$Provider.notifier).setSystem();
      expect(c.read(themeMode$Provider), ThemeMode.system);
    });

    test('toggle switches dark → light', () {
      final c = _makeContainer();
      addTearDown(c.dispose);
      c.read(themeMode$Provider.notifier).toggle();
      expect(c.read(themeMode$Provider), ThemeMode.light);
    });

    test('toggle switches light → dark', () {
      final c = _makeContainer();
      addTearDown(c.dispose);
      c.read(themeMode$Provider.notifier).setLight();
      c.read(themeMode$Provider.notifier).toggle();
      expect(c.read(themeMode$Provider), ThemeMode.dark);
    });
  });

  group('AppLocale provider', () {
    test('initial state is Ukrainian', () {
      final c = _makeContainer();
      addTearDown(c.dispose);
      expect(c.read(appLocaleProvider), const Locale('uk'));
    });

    test('setEnglish switches to English', () {
      final c = _makeContainer();
      addTearDown(c.dispose);
      c.read(appLocaleProvider.notifier).setEnglish();
      expect(c.read(appLocaleProvider), const Locale('en'));
    });

    test('setUkrainian switches back to Ukrainian', () {
      final c = _makeContainer();
      addTearDown(c.dispose);
      c.read(appLocaleProvider.notifier).setEnglish();
      c.read(appLocaleProvider.notifier).setUkrainian();
      expect(c.read(appLocaleProvider), const Locale('uk'));
    });

    test('setLocale sets arbitrary locale', () {
      final c = _makeContainer();
      addTearDown(c.dispose);
      c.read(appLocaleProvider.notifier).setLocale(const Locale('fr'));
      expect(c.read(appLocaleProvider), const Locale('fr'));
    });
  });
}
