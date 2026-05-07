import 'package:flutter_test/flutter_test.dart';
import 'package:hookah_mix_master/l10n/app_localizations_en.dart';
import 'package:hookah_mix_master/l10n/app_localizations_uk.dart';

void main() {
  group('L10n smoke test — all keys present in both locales', () {
    final en = AppLocalizationsEn();
    final uk = AppLocalizationsUk();

    test('appName', () {
      expect(en.appName, isNotEmpty);
      expect(uk.appName, isNotEmpty);
    });

    test('auth keys', () {
      expect(en.authLoginTitle, isNotEmpty);
      expect(uk.authLoginTitle, isNotEmpty);
      expect(en.authSignupTitle, isNotEmpty);
      expect(uk.authSignupTitle, isNotEmpty);
      expect(en.authAgeGateTitle, isNotEmpty);
      expect(uk.authAgeGateTitle, isNotEmpty);
    });

    test('catalog keys', () {
      expect(en.catalogTitle, isNotEmpty);
      expect(uk.catalogTitle, isNotEmpty);
      expect(en.catalogFilterBrand, isNotEmpty);
      expect(uk.catalogFilterBrand, isNotEmpty);
    });

    test('recommender keys', () {
      expect(en.recommenderTitle, isNotEmpty);
      expect(uk.recommenderTitle, isNotEmpty);
      expect(en.recommenderStepFlavor, isNotEmpty);
      expect(uk.recommenderStepFlavor, isNotEmpty);
    });

    test('builder keys', () {
      expect(en.builderTitle, isNotEmpty);
      expect(uk.builderTitle, isNotEmpty);
      expect(en.builderAddTobacco, isNotEmpty);
      expect(uk.builderAddTobacco, isNotEmpty);
    });

    test('profile keys', () {
      expect(en.profileTitle, isNotEmpty);
      expect(uk.profileTitle, isNotEmpty);
      expect(en.profileSettingsLanguage, isNotEmpty);
      expect(uk.profileSettingsLanguage, isNotEmpty);
    });

    test('general keys', () {
      expect(en.generalRetry, isNotEmpty);
      expect(uk.generalRetry, isNotEmpty);
      expect(en.generalError, isNotEmpty);
      expect(uk.generalError, isNotEmpty);
    });

    test('nav keys', () {
      expect(en.navCatalog, isNotEmpty);
      expect(uk.navCatalog, isNotEmpty);
      expect(en.navRecommender, isNotEmpty);
      expect(uk.navRecommender, isNotEmpty);
      expect(en.navBuilder, isNotEmpty);
      expect(uk.navBuilder, isNotEmpty);
      expect(en.navFavorites, isNotEmpty);
      expect(uk.navFavorites, isNotEmpty);
      expect(en.navProfile, isNotEmpty);
      expect(uk.navProfile, isNotEmpty);
    });
  });
}
