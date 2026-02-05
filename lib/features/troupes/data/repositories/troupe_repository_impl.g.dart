// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'troupe_repository_impl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(troupeRepository)
final troupeRepositoryProvider = TroupeRepositoryProvider._();

final class TroupeRepositoryProvider extends $FunctionalProvider<
    TroupeRepository,
    TroupeRepository,
    TroupeRepository> with $Provider<TroupeRepository> {
  TroupeRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'troupeRepositoryProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$troupeRepositoryHash();

  @$internal
  @override
  $ProviderElement<TroupeRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TroupeRepository create(Ref ref) {
    return troupeRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TroupeRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TroupeRepository>(value),
    );
  }
}

String _$troupeRepositoryHash() => r'2183dd180bf71ce382a3d96dae72441d148cfa60';
