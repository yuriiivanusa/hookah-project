// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ThemeMode$)
final themeMode$Provider = ThemeMode$Provider._();

final class ThemeMode$Provider
    extends $NotifierProvider<ThemeMode$, ThemeMode> {
  ThemeMode$Provider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'themeMode$Provider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$themeMode$Hash();

  @$internal
  @override
  ThemeMode$ create() => ThemeMode$();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ThemeMode value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ThemeMode>(value),
    );
  }
}

String _$themeMode$Hash() => r'ad4da367407ed7db1aeb0ce22842477885f77e7d';

abstract class _$ThemeMode$ extends $Notifier<ThemeMode> {
  ThemeMode build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<ThemeMode, ThemeMode>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ThemeMode, ThemeMode>,
              ThemeMode,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
