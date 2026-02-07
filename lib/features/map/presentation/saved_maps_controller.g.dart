// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saved_maps_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SavedMapsController)
final savedMapsControllerProvider = SavedMapsControllerProvider._();

final class SavedMapsControllerProvider
    extends $AsyncNotifierProvider<SavedMapsController, List<SavedMapRegion>> {
  SavedMapsControllerProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'savedMapsControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$savedMapsControllerHash();

  @$internal
  @override
  SavedMapsController create() => SavedMapsController();
}

String _$savedMapsControllerHash() =>
    r'7cf1380f420729ad534e29cb66943312d7079bb0';

abstract class _$SavedMapsController
    extends $AsyncNotifier<List<SavedMapRegion>> {
  FutureOr<List<SavedMapRegion>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref
        as $Ref<AsyncValue<List<SavedMapRegion>>, List<SavedMapRegion>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<List<SavedMapRegion>>, List<SavedMapRegion>>,
        AsyncValue<List<SavedMapRegion>>,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}
