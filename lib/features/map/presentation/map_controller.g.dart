// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(MapController)
final mapControllerProvider = MapControllerProvider._();

final class MapControllerProvider
    extends $AsyncNotifierProvider<MapController, Position?> {
  MapControllerProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'mapControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$mapControllerHash();

  @$internal
  @override
  MapController create() => MapController();
}

String _$mapControllerHash() => r'd4f4ba7d8ae282dc1a5cfb56619d6f40f747ed08';

abstract class _$MapController extends $AsyncNotifier<Position?> {
  FutureOr<Position?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<Position?>, Position?>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<Position?>, Position?>,
        AsyncValue<Position?>,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}
