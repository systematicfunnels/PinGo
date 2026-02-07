// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'record_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(RecordController)
final recordControllerProvider = RecordControllerProvider._();

final class RecordControllerProvider
    extends $NotifierProvider<RecordController, RecorderState> {
  RecordControllerProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'recordControllerProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$recordControllerHash();

  @$internal
  @override
  RecordController create() => RecordController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RecorderState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RecorderState>(value),
    );
  }
}

String _$recordControllerHash() => r'8f0889fd8f79644a188259b65f49af0d88c8ac6e';

abstract class _$RecordController extends $Notifier<RecorderState> {
  RecorderState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<RecorderState, RecorderState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<RecorderState, RecorderState>,
        RecorderState,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}
