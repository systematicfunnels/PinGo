// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'journey_repository_impl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(journeyRepository)
final journeyRepositoryProvider = JourneyRepositoryProvider._();

final class JourneyRepositoryProvider extends $FunctionalProvider<
    JourneyRepository,
    JourneyRepository,
    JourneyRepository> with $Provider<JourneyRepository> {
  JourneyRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'journeyRepositoryProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$journeyRepositoryHash();

  @$internal
  @override
  $ProviderElement<JourneyRepository> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  JourneyRepository create(Ref ref) {
    return journeyRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(JourneyRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<JourneyRepository>(value),
    );
  }
}

String _$journeyRepositoryHash() => r'c0db62dde2ba4b85f3f2b6e81506b6fff182ca66';

@ProviderFor(singleJourney)
final singleJourneyProvider = SingleJourneyFamily._();

final class SingleJourneyProvider extends $FunctionalProvider<
        AsyncValue<Journey?>, Journey?, FutureOr<Journey?>>
    with $FutureModifier<Journey?>, $FutureProvider<Journey?> {
  SingleJourneyProvider._(
      {required SingleJourneyFamily super.from, required int super.argument})
      : super(
          retry: null,
          name: r'singleJourneyProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$singleJourneyHash();

  @override
  String toString() {
    return r'singleJourneyProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Journey?> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Journey?> create(Ref ref) {
    final argument = this.argument as int;
    return singleJourney(
      ref,
      argument,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is SingleJourneyProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$singleJourneyHash() => r'7b6f10c2437d45952b86a63eccd7a64ad0d57413';

final class SingleJourneyFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Journey?>, int> {
  SingleJourneyFamily._()
      : super(
          retry: null,
          name: r'singleJourneyProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  SingleJourneyProvider call(
    int id,
  ) =>
      SingleJourneyProvider._(argument: id, from: this);

  @override
  String toString() => r'singleJourneyProvider';
}
