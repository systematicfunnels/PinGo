import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pingo/core/theme/app_theme.dart';
import 'package:pingo/core/presentation/widgets/molecules/molecules.dart';
import 'package:pingo/core/theme/spacing.dart';
import 'package:pingo/features/explore/presentation/controllers/explore_search_controller.dart';

class ExploreSearchView extends ConsumerStatefulWidget {
  const ExploreSearchView({super.key});

  @override
  ConsumerState<ExploreSearchView> createState() => _ExploreSearchViewState();
}

class _ExploreSearchViewState extends ConsumerState<ExploreSearchView> {
  late TextEditingController _controller;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: ref.read(exploreSearchQueryProvider),
    );
    // Focus after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchResultsAsync = ref.watch(exploreSearchResultsProvider);

    return Scaffold(
      backgroundColor: AppColors.neutral.s50,
      body: SafeArea(
        child: Column(
          children: [
            // Search Header
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      // Clear query on exit? Optional.
                      // ref.read(exploreSearchQueryProvider.notifier).setQuery('');
                      context.pop();
                    },
                  ),
                  Expanded(
                    child: PingoInputField(
                      controller: _controller,
                      focusNode: _focusNode,
                      onChanged: (value) {
                        ref
                            .read(exploreSearchQueryProvider.notifier)
                            .setQuery(value);
                      },
                      hintText: 'Search places, routes...',
                      prefixIcon:
                          Icon(Icons.search, color: AppColors.neutral.s700),
                    ),
                  ),
                ],
              ),
            ),

            // Results
            Expanded(
              child: searchResultsAsync.when(
                data: (results) {
                  if (results.isEmpty) {
                    if (_controller.text.length < 2) {
                      return const Center(
                        child: Text('Type at least 2 characters to search'),
                      );
                    }
                    return const Center(
                      child: Text('No results found'),
                    );
                  }

                  return ListView.separated(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    itemCount: results.length,
                    separatorBuilder: (_, __) => const Divider(),
                    itemBuilder: (context, index) {
                      final result = results[index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor:
                              AppColors.primary.s500.withValues(alpha: 0.1),
                          child: Icon(
                            result is PinSearchResult
                                ? Icons.location_on
                                : Icons.map,
                            color: AppColors.primary.s500,
                          ),
                        ),
                        title: Text(result.title),
                        subtitle: Text(result.subtitle),
                        onTap: () {
                          // Handle navigation based on result type
                          // For now, just show a snackbar or close search
                          if (result is PinSearchResult) {
                            // Navigate to Pin location on map (TODO)
                            context
                                .pop(result); // Return result to ExploreScreen
                          } else if (result is MapSearchResult) {
                            // Navigate to Map (TODO)
                            context.pop(result);
                          }
                        },
                      );
                    },
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, stack) => Center(child: Text('Error: $err')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
