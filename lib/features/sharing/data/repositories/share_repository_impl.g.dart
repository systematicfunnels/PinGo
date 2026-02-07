// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'share_repository_impl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(shareRepository)
final shareRepositoryProvider = ShareRepositoryProvider._();

final class ShareRepositoryProvider extends $FunctionalProvider<ShareRepository,
    ShareRepository, ShareRepository> with $Provider<ShareRepository> {
  ShareRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'shareRepositoryProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$shareRepositoryHash();

  @$internal
  @override
  $ProviderElement<ShareRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ShareRepository create(Ref ref) {
    return shareRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ShareRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ShareRepository>(value),
    );
  }
}

String _$shareRepositoryHash() => r'baa7257615e0191b1ffe5729ff4ff734b33dedcf';
