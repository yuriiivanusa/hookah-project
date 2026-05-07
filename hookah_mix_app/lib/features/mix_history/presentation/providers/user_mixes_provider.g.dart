// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_mixes_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(UserMixesNotifier)
final userMixesProvider = UserMixesNotifierProvider._();

final class UserMixesNotifierProvider
    extends $NotifierProvider<UserMixesNotifier, List<UserMix>> {
  UserMixesNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userMixesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userMixesNotifierHash();

  @$internal
  @override
  UserMixesNotifier create() => UserMixesNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<UserMix> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<UserMix>>(value),
    );
  }
}

String _$userMixesNotifierHash() => r'9187089346c3c24d03782a08526fa0bb1c63a3ac';

abstract class _$UserMixesNotifier extends $Notifier<List<UserMix>> {
  List<UserMix> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<List<UserMix>, List<UserMix>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<UserMix>, List<UserMix>>,
              List<UserMix>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
