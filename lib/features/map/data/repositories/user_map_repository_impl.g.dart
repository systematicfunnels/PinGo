// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_map_repository_impl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(userMapRepository)
final userMapRepositoryProvider = UserMapRepositoryProvider._();

final class UserMapRepositoryProvider extends $FunctionalProvider<
    UserMapRepository,
    UserMapRepository,
    UserMapRepository> with $Provider<UserMapRepository> {
  UserMapRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'userMapRepositoryProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$userMapRepositoryHash();

  @$internal
  @override
  $ProviderElement<UserMapRepository> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  UserMapRepository create(Ref ref) {
    return userMapRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UserMapRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UserMapRepository>(value),
    );
  }
}

String _$userMapRepositoryHash() => r'56d117c305bb8bee6aee50be79d4371a3c21b874';
