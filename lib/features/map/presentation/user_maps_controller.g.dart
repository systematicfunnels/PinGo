// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_maps_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(UserMapsController)
final userMapsControllerProvider = UserMapsControllerProvider._();

final class UserMapsControllerProvider
    extends $StreamNotifierProvider<UserMapsController, List<UserMap>> {
  UserMapsControllerProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'userMapsControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$userMapsControllerHash();

  @$internal
  @override
  UserMapsController create() => UserMapsController();
}

String _$userMapsControllerHash() =>
    r'5ce6f474cba77d4c78e0e7270e4c7cd17c4fa6aa';

abstract class _$UserMapsController extends $StreamNotifier<List<UserMap>> {
  Stream<List<UserMap>> build();
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
