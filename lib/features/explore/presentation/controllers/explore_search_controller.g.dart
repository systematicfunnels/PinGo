// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'explore_search_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ExploreSearchQuery)
final exploreSearchQueryProvider = ExploreSearchQueryProvider._();

final class ExploreSearchQueryProvider
    extends $NotifierProvider<ExploreSearchQuery, String> {
  ExploreSearchQueryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'exploreSearchQueryProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$exploreSearchQueryHash();

  @$internal
  @override
  ExploreSearchQuery create() => ExploreSearchQuery();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$exploreSearchQueryHash() =>
    r'569d2a7805e6b3cabcb21e96c2abf3a0284e1035';

abstract class _$ExploreSearchQuery extends $Notifier<String> {
  String build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<String, String>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<String, String>, String, Object?, Object?>;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(exploreSearchResults)
final exploreSearchResultsProvider = ExploreSearchResultsProvider._();

final class ExploreSearchResultsProvider extends $FunctionalProvider<
        AsyncValue<List<ExploreSearchResult>>,
        List<ExploreSearchResult>,
        FutureOr<List<ExploreSearchResult>>>
    with
        $FutureModifier<List<ExploreSearchResult>>,
        $FutureProvider<List<ExploreSearchResult>> {
  ExploreSearchResultsProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'exploreSearchResultsProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$exploreSearchResultsHash();

  @$internal
  @override
  $FutureProviderElement<List<ExploreSearchResult>> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<ExploreSearchResult>> create(Ref ref) {
    return exploreSearchResults(ref);
  }
}

String _$exploreSearchResultsHash() =>
    r'038c1a1f89a6dc653e43ea6a0a4d2064f15d2646';
