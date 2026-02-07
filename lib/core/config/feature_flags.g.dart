// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feature_flags.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(featureFlags)
final featureFlagsProvider = FeatureFlagsProvider._();

final class FeatureFlagsProvider
    extends $FunctionalProvider<FeatureFlags, FeatureFlags, FeatureFlags>
    with $Provider<FeatureFlags> {
  FeatureFlagsProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'featureFlagsProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$featureFlagsHash();

  @$internal
  @override
  $ProviderElement<FeatureFlags> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  FeatureFlags create(Ref ref) {
    return featureFlags(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FeatureFlags value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FeatureFlags>(value),
    );
  }
}

String _$featureFlagsHash() => r'65a762e068fffce6cb837ec7e07bc130b8febd6d';
