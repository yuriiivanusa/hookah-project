// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wizard_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(WizardNotifier)
final wizardProvider = WizardNotifierProvider._();

final class WizardNotifierProvider
    extends $NotifierProvider<WizardNotifier, WizardState> {
  WizardNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'wizardProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$wizardNotifierHash();

  @$internal
  @override
  WizardNotifier create() => WizardNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WizardState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WizardState>(value),
    );
  }
}

String _$wizardNotifierHash() => r'd9c5119a37b58de0ebbc62d3b9ad69ca23bb116c';

abstract class _$WizardNotifier extends $Notifier<WizardState> {
  WizardState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<WizardState, WizardState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<WizardState, WizardState>,
              WizardState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
