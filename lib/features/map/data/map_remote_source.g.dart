// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_remote_source.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(mapRemoteSource)
final mapRemoteSourceProvider = MapRemoteSourceProvider._();

final class MapRemoteSourceProvider extends $FunctionalProvider<MapRemoteSource,
    MapRemoteSource, MapRemoteSource> with $Provider<MapRemoteSource> {
  MapRemoteSourceProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'mapRemoteSourceProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$mapRemoteSourceHash();

  @$internal
  @override
  $ProviderElement<MapRemoteSource> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  MapRemoteSource create(Ref ref) {
    return mapRemoteSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MapRemoteSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MapRemoteSource>(value),
    );
  }
}

String _$mapRemoteSourceHash() => r'f5d7f9e766684d7756f2738b4c26610f01b12a44';
