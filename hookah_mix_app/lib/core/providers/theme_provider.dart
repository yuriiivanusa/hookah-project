import 'package:flutter/material.dart';
import 'package:hookah_mix_master/core/constants/string_constants.dart';
import 'package:hookah_mix_master/core/services/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_provider.g.dart';

@Riverpod(keepAlive: true)
class ThemeMode$ extends _$ThemeMode$ {
  static const _box = StringConstants.userPrefsBoxName;
  static const _key = 'theme_mode';

  @override
  ThemeMode build() {
    final raw = ref.watch(hiveServiceProvider).get(_box, _key);
    return switch (raw) {
      'light' => ThemeMode.light,
      'system' => ThemeMode.system,
      _ => ThemeMode.dark,
    };
  }

  void setDark() => _update(ThemeMode.dark, 'dark');
  void setLight() => _update(ThemeMode.light, 'light');
  void setSystem() => _update(ThemeMode.system, 'system');

  void toggle() => state == ThemeMode.dark ? setLight() : setDark();

  void _update(ThemeMode mode, String raw) {
    state = mode;
    ref.read(hiveServiceProvider).put(_box, _key, raw);
  }
}
