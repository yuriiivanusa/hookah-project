// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recommendations_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(recommendationRepository)
final recommendationRepositoryProvider = RecommendationRepositoryProvider._();

final class RecommendationRepositoryProvider
    extends
        $FunctionalProvider<
          RecommendationRepository,
          RecommendationRepository,
          RecommendationRepository
        >
    with $Provider<RecommendationRepository> {
  RecommendationRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'recommendationRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$recommendationRepositoryHash();

  @$internal
  @override
  $ProviderElement<RecommendationRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  RecommendationRepository create(Ref ref) {
    return recommendationRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RecommendationRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RecommendationRepository>(value),
    );
  }
}

String _$recommendationRepositoryHash() =>
    r'a169a87446123565d584f510376c2dc2a8f31485';

@ProviderFor(curatedMixById)
final curatedMixByIdProvider = CuratedMixByIdFamily._();

final class CuratedMixByIdProvider
    extends
        $FunctionalProvider<
          AsyncValue<CuratedMix?>,
          CuratedMix?,
          FutureOr<CuratedMix?>
        >
    with $FutureModifier<CuratedMix?>, $FutureProvider<CuratedMix?> {
  CuratedMixByIdProvider._({
    required CuratedMixByIdFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'curatedMixByIdProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$curatedMixByIdHash();

  @override
  String toString() {
    return r'curatedMixByIdProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<CuratedMix?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<CuratedMix?> create(Ref ref) {
    final argument = this.argument as String;
    return curatedMixById(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is CuratedMixByIdProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$curatedMixByIdHash() => r'0570b2b7030eb5e6d332c788aff247c0806fc88d';

final class CuratedMixByIdFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<CuratedMix?>, String> {
  CuratedMixByIdFamily._()
    : super(
        retry: null,
        name: r'curatedMixByIdProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CuratedMixByIdProvider call(String id) =>
      CuratedMixByIdProvider._(argument: id, from: this);

  @override
  String toString() => r'curatedMixByIdProvider';
}

@ProviderFor(recommendations)
final recommendationsProvider = RecommendationsProvider._();

final class RecommendationsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<RecommendationResult>>,
          List<RecommendationResult>,
          FutureOr<List<RecommendationResult>>
        >
    with
        $FutureModifier<List<RecommendationResult>>,
        $FutureProvider<List<RecommendationResult>> {
  RecommendationsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'recommendationsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$recommendationsHash();

  @$internal
  @override
  $FutureProviderElement<List<RecommendationResult>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<RecommendationResult>> create(Ref ref) {
    return recommendations(ref);
  }
}

String _$recommendationsHash() => r'82b7b252c4cf4247bf0f1d0ee137529dbf5941bf';
