// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'explore_feed_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ExploreFeedController)
final exploreFeedControllerProvider = ExploreFeedControllerProvider._();

final class ExploreFeedControllerProvider
    extends $AsyncNotifierProvider<ExploreFeedController, List<UserMap>> {
  ExploreFeedControllerProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'exploreFeedControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$exploreFeedControllerHash();

  @$internal
  @override
  ExploreFeedController create() => ExploreFeedController();
}

String _$exploreFeedControllerHash() =>
    r'c4cd9402e8f0a5c7bc5c910c116f713f8f9a94a6';

abstract class _$ExploreFeedController extends $AsyncNotifier<List<UserMap>> {
  FutureOr<List<UserMap>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<UserMap>>, List<UserMap>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<List<UserMap>>, List<UserMap>>,
        AsyncValue<List<UserMap>>,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}
