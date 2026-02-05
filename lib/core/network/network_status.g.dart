// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'network_status.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(networkStatus)
final networkStatusProvider = NetworkStatusProvider._();

final class NetworkStatusProvider
    extends $FunctionalProvider<NetworkStatus, NetworkStatus, NetworkStatus>
    with $Provider<NetworkStatus> {
  NetworkStatusProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'networkStatusProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$networkStatusHash();

  @$internal
  @override
  $ProviderElement<NetworkStatus> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  NetworkStatus create(Ref ref) {
    return networkStatus(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NetworkStatus value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NetworkStatus>(value),
    );
  }
}

String _$networkStatusHash() => r'1b9bf9cd867ee965af3297ad3dba3a5e1f78bdcc';
