// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pins_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PinsController)
final pinsControllerProvider = PinsControllerProvider._();

final class PinsControllerProvider
    extends $StreamNotifierProvider<PinsController, List<Pin>> {
  PinsControllerProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'pinsControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$pinsControllerHash();

  @$internal
  @override
  PinsController create() => PinsController();
}

String _$pinsControllerHash() => r'bf151742a25e7dc8e36243f45ff32aaf3add1395';

abstract class _$PinsController extends $StreamNotifier<List<Pin>> {
  Stream<List<Pin>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Pin>>, List<Pin>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<List<Pin>>, List<Pin>>,
        AsyncValue<List<Pin>>,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}
