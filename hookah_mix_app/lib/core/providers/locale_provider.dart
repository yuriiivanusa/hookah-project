import 'dart:ui';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'locale_provider.g.dart';

@Riverpod(keepAlive: true)
class AppLocale extends _$AppLocale {
  @override
  Locale build() => const Locale('uk');

  void setEnglish() => state = const Locale('en');
  void setUkrainian() => state = const Locale('uk');
  void setLocale(Locale locale) => state = locale;
}
