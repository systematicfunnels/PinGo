// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sync_queue.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(syncQueue)
final syncQueueProvider = SyncQueueProvider._();

final class SyncQueueProvider
    extends $FunctionalProvider<SyncQueue, SyncQueue, SyncQueue>
    with $Provider<SyncQueue> {
  SyncQueueProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'syncQueueProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$syncQueueHash();

  @$internal
  @override
  $ProviderElement<SyncQueue> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SyncQueue create(Ref ref) {
    return syncQueue(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SyncQueue value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SyncQueue>(value),
    );
  }
}

String _$syncQueueHash() => r'0b1b202b95799bd145384be423cbf87cda571485';
