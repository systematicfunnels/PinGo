// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_local_source.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(mapLocalSource)
final mapLocalSourceProvider = MapLocalSourceProvider._();

final class MapLocalSourceProvider
    extends $FunctionalProvider<MapLocalSource, MapLocalSource, MapLocalSource>
    with $Provider<MapLocalSource> {
  MapLocalSourceProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'mapLocalSourceProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$mapLocalSourceHash();

  @$internal
  @override
  $ProviderElement<MapLocalSource> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  MapLocalSource create(Ref ref) {
    return mapLocalSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MapLocalSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MapLocalSource>(value),
    );
  }
}

String _$mapLocalSourceHash() => r'415c22b4c6be27bae82d18548cdcb79bea737979';
