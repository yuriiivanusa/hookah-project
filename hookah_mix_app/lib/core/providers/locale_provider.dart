import 'dart:ui';

import 'package:hookah_mix_master/core/constants/string_constants.dart';
import 'package:hookah_mix_master/core/services/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'locale_provider.g.dart';

@Riverpod(keepAlive: true)
class AppLocale extends _$AppLocale {
  static const _box = StringConstants.userPrefsBoxName;
  static const _key = 'app_locale';

  @override
  Locale build() {
    final raw = ref.watch(hiveServiceProvider).get(_box, _key);
    return raw != null ? Locale(raw) : const Locale('uk');
  }

  void setEnglish() => _update(const Locale('en'));
  void setUkrainian() => _update(const Locale('uk'));
  void setLocale(Locale locale) => _update(locale);

  void _update(Locale locale) {
    state = locale;
    ref.read(hiveServiceProvider).put(_box, _key, locale.languageCode);
  }
}
