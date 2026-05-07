// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'catalog_filter_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CatalogFilter)
final catalogFilterProvider = CatalogFilterProvider._();

final class CatalogFilterProvider
    extends $NotifierProvider<CatalogFilter, TobaccoFilter> {
  CatalogFilterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'catalogFilterProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$catalogFilterHash();

  @$internal
  @override
  CatalogFilter create() => CatalogFilter();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TobaccoFilter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TobaccoFilter>(value),
    );
  }
}

String _$catalogFilterHash() => r'a485a622cb59c9de2b59747fb539f5a524ba241a';

abstract class _$CatalogFilter extends $Notifier<TobaccoFilter> {
  TobaccoFilter build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<TobaccoFilter, TobaccoFilter>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<TobaccoFilter, TobaccoFilter>,
              TobaccoFilter,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
