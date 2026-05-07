// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tobacco_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(tobaccoRepository)
final tobaccoRepositoryProvider = TobaccoRepositoryProvider._();

final class TobaccoRepositoryProvider
    extends
        $FunctionalProvider<
          TobaccoRepository,
          TobaccoRepository,
          TobaccoRepository
        >
    with $Provider<TobaccoRepository> {
  TobaccoRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'tobaccoRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$tobaccoRepositoryHash();

  @$internal
  @override
  $ProviderElement<TobaccoRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  TobaccoRepository create(Ref ref) {
    return tobaccoRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TobaccoRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TobaccoRepository>(value),
    );
  }
}

String _$tobaccoRepositoryHash() => r'97654c0baf6505a051d7ca04613a28ff0199d31c';

@ProviderFor(tobaccoList)
final tobaccoListProvider = TobaccoListProvider._();

final class TobaccoListProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Tobacco>>,
          List<Tobacco>,
          FutureOr<List<Tobacco>>
        >
    with $FutureModifier<List<Tobacco>>, $FutureProvider<List<Tobacco>> {
  TobaccoListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'tobaccoListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$tobaccoListHash();

  @$internal
  @override
  $FutureProviderElement<List<Tobacco>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Tobacco>> create(Ref ref) {
    return tobaccoList(ref);
  }
}

String _$tobaccoListHash() => r'f8b5b8b6f22dd80e1a2ee4dcc91791ef08d19eb9';

@ProviderFor(brandList)
final brandListProvider = BrandListProvider._();

final class BrandListProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Brand>>,
          List<Brand>,
          FutureOr<List<Brand>>
        >
    with $FutureModifier<List<Brand>>, $FutureProvider<List<Brand>> {
  BrandListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'brandListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$brandListHash();

  @$internal
  @override
  $FutureProviderElement<List<Brand>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Brand>> create(Ref ref) {
    return brandList(ref);
  }
}

String _$brandListHash() => r'f133aef9fc9cc3711fedb623deb6b4b5ade91212';

@ProviderFor(tobaccoDetail)
final tobaccoDetailProvider = TobaccoDetailFamily._();

final class TobaccoDetailProvider
    extends
        $FunctionalProvider<AsyncValue<Tobacco?>, Tobacco?, FutureOr<Tobacco?>>
    with $FutureModifier<Tobacco?>, $FutureProvider<Tobacco?> {
  TobaccoDetailProvider._({
    required TobaccoDetailFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'tobaccoDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$tobaccoDetailHash();

  @override
  String toString() {
    return r'tobaccoDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Tobacco?> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Tobacco?> create(Ref ref) {
    final argument = this.argument as String;
    return tobaccoDetail(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is TobaccoDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$tobaccoDetailHash() => r'77846e18138c8fe7af233d4d9714e6c6392b8145';

final class TobaccoDetailFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Tobacco?>, String> {
  TobaccoDetailFamily._()
    : super(
        retry: null,
        name: r'tobaccoDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  TobaccoDetailProvider call(String id) =>
      TobaccoDetailProvider._(argument: id, from: this);

  @override
  String toString() => r'tobaccoDetailProvider';
}

@ProviderFor(filteredTobaccoList)
final filteredTobaccoListProvider = FilteredTobaccoListProvider._();

final class FilteredTobaccoListProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Tobacco>>,
          List<Tobacco>,
          FutureOr<List<Tobacco>>
        >
    with $FutureModifier<List<Tobacco>>, $FutureProvider<List<Tobacco>> {
  FilteredTobaccoListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'filteredTobaccoListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$filteredTobaccoListHash();

  @$internal
  @override
  $FutureProviderElement<List<Tobacco>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Tobacco>> create(Ref ref) {
    return filteredTobaccoList(ref);
  }
}

String _$filteredTobaccoListHash() =>
    r'd361c90ea5cf87bac7f35333d013af502fde17ef';
