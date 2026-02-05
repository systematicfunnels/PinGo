// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'troupes_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(TroupesController)
final troupesControllerProvider = TroupesControllerProvider._();

final class TroupesControllerProvider
    extends $StreamNotifierProvider<TroupesController, List<Troupe>> {
  TroupesControllerProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'troupesControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$troupesControllerHash();

  @$internal
  @override
  TroupesController create() => TroupesController();
}

String _$troupesControllerHash() => r'8ab6cb8a5037b0a30f3e750abe45b29259ec5a04';

abstract class _$TroupesController extends $StreamNotifier<List<Troupe>> {
  Stream<List<Troupe>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Troupe>>, List<Troupe>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<List<Troupe>>, List<Troupe>>,
        AsyncValue<List<Troupe>>,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}
