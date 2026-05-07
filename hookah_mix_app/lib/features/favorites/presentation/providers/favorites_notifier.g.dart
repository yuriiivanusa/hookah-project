// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorites_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(favoritesRepository)
final favoritesRepositoryProvider = FavoritesRepositoryProvider._();

final class FavoritesRepositoryProvider
    extends
        $FunctionalProvider<
          FavoritesRepository,
          FavoritesRepository,
          FavoritesRepository
        >
    with $Provider<FavoritesRepository> {
  FavoritesRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'favoritesRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$favoritesRepositoryHash();

  @$internal
  @override
  $ProviderElement<FavoritesRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  FavoritesRepository create(Ref ref) {
    return favoritesRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FavoritesRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FavoritesRepository>(value),
    );
  }
}

String _$favoritesRepositoryHash() =>
    r'759138c8a80efc518fbac5b8014269e54a8fe528';

@ProviderFor(FavoritesNotifier)
final favoritesProvider = FavoritesNotifierProvider._();

final class FavoritesNotifierProvider
    extends $NotifierProvider<FavoritesNotifier, List<FavoriteEntry>> {
  FavoritesNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'favoritesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$favoritesNotifierHash();

  @$internal
  @override
  FavoritesNotifier create() => FavoritesNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<FavoriteEntry> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<FavoriteEntry>>(value),
    );
  }
}

String _$favoritesNotifierHash() => r'18095e8acb866ead8f1b98adefc24e4f7d53eb98';

abstract class _$FavoritesNotifier extends $Notifier<List<FavoriteEntry>> {
  List<FavoriteEntry> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<List<FavoriteEntry>, List<FavoriteEntry>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<FavoriteEntry>, List<FavoriteEntry>>,
              List<FavoriteEntry>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
