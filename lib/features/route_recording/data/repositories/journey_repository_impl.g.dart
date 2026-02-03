// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'journey_repository_impl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$journeyRepositoryHash() => r'c0db62dde2ba4b85f3f2b6e81506b6fff182ca66';

/// See also [journeyRepository].
@ProviderFor(journeyRepository)
final journeyRepositoryProvider = Provider<JourneyRepository>.internal(
  journeyRepository,
  name: r'journeyRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$journeyRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef JourneyRepositoryRef = ProviderRef<JourneyRepository>;
String _$singleJourneyHash() => r'71cd9a11131a6630646401183e61e41ba27081c3';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [singleJourney].
@ProviderFor(singleJourney)
const singleJourneyProvider = SingleJourneyFamily();

/// See also [singleJourney].
class SingleJourneyFamily extends Family<AsyncValue<Journey?>> {
  /// See also [singleJourney].
  const SingleJourneyFamily();

  /// See also [singleJourney].
  SingleJourneyProvider call(
    String id,
  ) {
    return SingleJourneyProvider(
      id,
    );
  }

  @override
  SingleJourneyProvider getProviderOverride(
    covariant SingleJourneyProvider provider,
  ) {
    return call(
      provider.id,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'singleJourneyProvider';
}

/// See also [singleJourney].
class SingleJourneyProvider extends AutoDisposeFutureProvider<Journey?> {
  /// See also [singleJourney].
  SingleJourneyProvider(
    String id,
  ) : this._internal(
          (ref) => singleJourney(
            ref as SingleJourneyRef,
            id,
          ),
          from: singleJourneyProvider,
          name: r'singleJourneyProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$singleJourneyHash,
          dependencies: SingleJourneyFamily._dependencies,
          allTransitiveDependencies:
              SingleJourneyFamily._allTransitiveDependencies,
          id: id,
        );

  SingleJourneyProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  Override overrideWith(
    FutureOr<Journey?> Function(SingleJourneyRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SingleJourneyProvider._internal(
        (ref) => create(ref as SingleJourneyRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Journey?> createElement() {
    return _SingleJourneyProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SingleJourneyProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SingleJourneyRef on AutoDisposeFutureProviderRef<Journey?> {
  /// The parameter `id` of this provider.
  String get id;
}

class _SingleJourneyProviderElement
    extends AutoDisposeFutureProviderElement<Journey?> with SingleJourneyRef {
  _SingleJourneyProviderElement(super.provider);

  @override
  String get id => (origin as SingleJourneyProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
