// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mix_builder_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(mixBuilderRepository)
final mixBuilderRepositoryProvider = MixBuilderRepositoryProvider._();

final class MixBuilderRepositoryProvider
    extends
        $FunctionalProvider<
          MixBuilderRepository,
          MixBuilderRepository,
          MixBuilderRepository
        >
    with $Provider<MixBuilderRepository> {
  MixBuilderRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mixBuilderRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mixBuilderRepositoryHash();

  @$internal
  @override
  $ProviderElement<MixBuilderRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  MixBuilderRepository create(Ref ref) {
    return mixBuilderRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MixBuilderRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MixBuilderRepository>(value),
    );
  }
}

String _$mixBuilderRepositoryHash() =>
    r'2ae08c9995e1666898ce6aed77f5598888465a1d';

@ProviderFor(MixBuilderNotifier)
final mixBuilderProvider = MixBuilderNotifierProvider._();

final class MixBuilderNotifierProvider
    extends $NotifierProvider<MixBuilderNotifier, CurrentMixState> {
  MixBuilderNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mixBuilderProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mixBuilderNotifierHash();

  @$internal
  @override
  MixBuilderNotifier create() => MixBuilderNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CurrentMixState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CurrentMixState>(value),
    );
  }
}

String _$mixBuilderNotifierHash() =>
    r'c4ce5eb247068d92875019479b35959d934e9a38';

abstract class _$MixBuilderNotifier extends $Notifier<CurrentMixState> {
  CurrentMixState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<CurrentMixState, CurrentMixState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<CurrentMixState, CurrentMixState>,
              CurrentMixState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
