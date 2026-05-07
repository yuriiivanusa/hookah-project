import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hookah_mix_master/core/providers/locale_provider.dart';
import 'package:hookah_mix_master/core/providers/theme_provider.dart';
import 'package:hookah_mix_master/core/services/local/hive_service.dart';
import 'package:hookah_mix_master/core/services/providers.dart';

class _FakeHiveService extends Fake implements HiveService {
  final _store = <String, Map<String, String>>{};

  @override
  String? get(String boxName, String key) => _store[boxName]?[key];

  @override
  Future<void> put(String boxName, String key, String value) async {
    (_store[boxName] ??= {})[key] = value;
  }
}

ProviderContainer _makeContainer({_FakeHiveService? hive}) => ProviderContainer(
  overrides: [
    hiveServiceProvider.overrideWithValue(hive ?? _FakeHiveService()),
  ],
);

void main() {
  group('ThemeMode\$ provider', () {
    test('initial state is dark when no prefs saved', () {
      final c = _makeContainer();
      addTearDown(c.dispose);
      expect(c.read(themeMode$Provider), ThemeMode.dark);
    });

    test('reads persisted light theme on build', () {
      final hive = _FakeHiveService();
      hive.put('user_prefs', 'theme_mode', 'light');
      final c = _makeContainer(hive: hive);
      addTearDown(c.dispose);
      expect(c.read(themeMode$Provider), ThemeMode.light);
    });

    test('reads persisted system theme on build', () {
      final hive = _FakeHiveService();
      hive.put('user_prefs', 'theme_mode', 'system');
      final c = _makeContainer(hive: hive);
      addTearDown(c.dispose);
      expect(c.read(themeMode$Provider), ThemeMode.system);
    });

    test('setLight persists to Hive', () {
      final hive = _FakeHiveService();
      final c = _makeContainer(hive: hive);
      addTearDown(c.dispose);
      c.read(themeMode$Provider.notifier).setLight();
      expect(c.read(themeMode$Provider), ThemeMode.light);
      expect(hive.get('user_prefs', 'theme_mode'), 'light');
    });

    test('setDark persists to Hive', () {
      final hive = _FakeHiveService();
      final c = _makeContainer(hive: hive);
      addTearDown(c.dispose);
      c.read(themeMode$Provider.notifier).setLight();
      c.read(themeMode$Provider.notifier).setDark();
      expect(c.read(themeMode$Provider), ThemeMode.dark);
      expect(hive.get('user_prefs', 'theme_mode'), 'dark');
    });

    test('setSystem persists to Hive', () {
      final hive = _FakeHiveService();
      final c = _makeContainer(hive: hive);
      addTearDown(c.dispose);
      c.read(themeMode$Provider.notifier).setSystem();
      expect(hive.get('user_prefs', 'theme_mode'), 'system');
    });

    test('toggle dark → light', () {
      final c = _makeContainer();
      addTearDown(c.dispose);
      c.read(themeMode$Provider.notifier).toggle();
      expect(c.read(themeMode$Provider), ThemeMode.light);
    });

    test('toggle light → dark', () {
      final c = _makeContainer();
      addTearDown(c.dispose);
      c.read(themeMode$Provider.notifier).setLight();
      c.read(themeMode$Provider.notifier).toggle();
      expect(c.read(themeMode$Provider), ThemeMode.dark);
    });
  });

  group('AppLocale provider', () {
    test('initial state is Ukrainian when no prefs saved', () {
      final c = _makeContainer();
      addTearDown(c.dispose);
      expect(c.read(appLocaleProvider), const Locale('uk'));
    });

    test('reads persisted English locale on build', () {
      final hive = _FakeHiveService();
      hive.put('user_prefs', 'app_locale', 'en');
      final c = _makeContainer(hive: hive);
      addTearDown(c.dispose);
      expect(c.read(appLocaleProvider), const Locale('en'));
    });

    test('setEnglish persists to Hive', () {
      final hive = _FakeHiveService();
      final c = _makeContainer(hive: hive);
      addTearDown(c.dispose);
      c.read(appLocaleProvider.notifier).setEnglish();
      expect(c.read(appLocaleProvider), const Locale('en'));
      expect(hive.get('user_prefs', 'app_locale'), 'en');
    });

    test('setUkrainian persists to Hive', () {
      final hive = _FakeHiveService();
      final c = _makeContainer(hive: hive);
      addTearDown(c.dispose);
      c.read(appLocaleProvider.notifier).setEnglish();
      c.read(appLocaleProvider.notifier).setUkrainian();
      expect(hive.get('user_prefs', 'app_locale'), 'uk');
    });

    test('setLocale persists arbitrary locale', () {
      final hive = _FakeHiveService();
      final c = _makeContainer(hive: hive);
      addTearDown(c.dispose);
      c.read(appLocaleProvider.notifier).setLocale(const Locale('fr'));
      expect(c.read(appLocaleProvider), const Locale('fr'));
      expect(hive.get('user_prefs', 'app_locale'), 'fr');
    });
  });
}
