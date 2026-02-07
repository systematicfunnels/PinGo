import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pingo/core/theme/app_theme.dart';
import 'package:pingo/core/theme/elevation.dart';
import 'package:pingo/core/theme/radius.dart';
import 'package:pingo/core/theme/spacing.dart';
import 'package:pingo/core/presentation/widgets/molecules/pingo_button.dart';
import 'package:pingo/features/explore/presentation/controllers/explore_feed_controller.dart';
import 'package:pingo/features/map/domain/map_entity.dart';

class DiscoverSheet extends ConsumerWidget {
  const DiscoverSheet({super.key});

  void _showComingSoon(BuildContext context, String item) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Coming soon: $item')),
    );
  }

  void _showMapPreview(BuildContext context, UserMap map) {
    // For now, show a bottom sheet or simple dialog as preview
    // In full implementation, this would navigate to a detailed Map Preview Screen
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.neutral.s100,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.6,
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: AppSpacing.xxl,
                height: AppSpacing.xs,
                decoration: BoxDecoration(
                  color: AppColors.neutral.s300,
                  borderRadius: AppRadius.allFull,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(map.name, style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: AppSpacing.sm),
            Text('by ${map.authorName}',
                style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: AppSpacing.md),
            Text(map.description ?? 'No description',
                style: Theme.of(context).textTheme.bodyLarge),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: PingoButton.primary(
                onPressed: () {
                  Navigator.pop(context);
                  _showComingSoon(context, 'Add to Library');
                },
                leadingIcon: Icons.bookmark_border,
                label: 'Add to Library',
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final feedAsync = ref.watch(exploreFeedControllerProvider);

    return DraggableScrollableSheet(
      initialChildSize: 0.12,
      minChildSize: 0.12,
      maxChildSize: 0.8,
      snap: true,
      snapSizes: const [0.12, 0.4, 0.8],
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.neutral.s100,
            borderRadius: AppRadius.top16,
            boxShadow: AppElevation.modal,
          ),
          child: RefreshIndicator(
            onRefresh: () => ref.refresh(exploreFeedControllerProvider.future),
            edgeOffset: 0,
            child: CustomScrollView(
              controller: scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      // Handle
                      Container(
                        width: 40,
                        height: 4,
                        margin:
                            const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                        decoration: BoxDecoration(
                          color: AppColors.neutral.s500.withValues(alpha: 0.3),
                          borderRadius: AppRadius.allFull,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                    ],
                  ),
                ),

                // Header
                SliverPadding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Discover',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        // Categories
                        _buildSectionTitle(context, 'Categories'),
                        const SizedBox(height: AppSpacing.sm),
                        SizedBox(
                          height: 100,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              _CategoryCard(
                                icon: Icons.restaurant,
                                label: 'Food',
                                onTap: () =>
                                    _showComingSoon(context, 'Food Category'),
                              ),
                              _CategoryCard(
                                icon: Icons.hiking,
                                label: 'Trails',
                                onTap: () =>
                                    _showComingSoon(context, 'Trails Category'),
                              ),
                              _CategoryCard(
                                icon: Icons.camera_alt,
                                label: 'Views',
                                onTap: () =>
                                    _showComingSoon(context, 'Views Category'),
                              ),
                              _CategoryCard(
                                icon: Icons.history_edu,
                                label: 'History',
                                onTap: () => _showComingSoon(
                                    context, 'History Category'),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xl),
                        _buildSectionTitle(context, 'Trending Maps'),
                        const SizedBox(height: AppSpacing.sm),
                      ],
                    ),
                  ),
                ),

                // Feed Content
                feedAsync.when(
                  data: (maps) {
                    if (maps.isEmpty) {
                      return const SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.all(AppSpacing.xl),
                          child:
                              Center(child: Text("Explore nearby to see maps")),
                        ),
                      );
                    }
                    return SliverPadding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            if (index == maps.length) {
                              // Footer: "You're all caught up"
                              return Padding(
                                padding: const EdgeInsets.all(AppSpacing.xl),
                                child: Center(
                                  child: Text(
                                    "You're all caught up",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                          color: AppColors.neutral.s500,
                                        ),
                                  ),
                                ),
                              );
                            }
                            final map = maps[index];
                            return FeedMapCard(
                              map: map,
                              onTap: () => _showMapPreview(context, map),
                              onSave: () =>
                                  _showComingSoon(context, 'Save Map'),
                              onFollow: () =>
                                  _showComingSoon(context, 'Follow Author'),
                            );
                          },
                          childCount: maps.length + 1, // +1 for footer
                        ),
                      ),
                    );
                  },
                  loading: () => const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.all(AppSpacing.xl),
                      child: Center(
                          child: CircularProgressIndicator(strokeWidth: 2)),
                    ),
                  ),
                  error: (err, stack) => SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.xl),
                      child: Center(
                        child: Column(
                          children: [
                            const Text("Could not load feed"),
                            TextButton(
                              onPressed: () =>
                                  ref.refresh(exploreFeedControllerProvider),
                              child: const Text("Try again"),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  const _CategoryCard({
    required this.icon,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Material(
            color: AppColors.primary.s500.withValues(alpha: 0.1),
            shape: const CircleBorder(),
            child: InkWell(
              onTap: onTap,
              customBorder: const CircleBorder(),
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Icon(icon, color: AppColors.primary.s500),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class FeedMapCard extends StatelessWidget {
  final UserMap map;
  final VoidCallback onTap;
  final VoidCallback onSave;
  final VoidCallback onFollow;

  const FeedMapCard({
    super.key,
    required this.map,
    required this.onTap,
    required this.onSave,
    required this.onFollow,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.lg),
      child: GestureDetector(
        onTap: () {
          HapticFeedback.lightImpact(); // "Subtle haptic"
          onTap();
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppSpacing.md),
            border: Border.all(color: AppColors.neutral.s300),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image Placeholder (Map Preview)
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(AppSpacing.md)),
                child: Container(
                  height: 150,
                  width: double.infinity,
                  color: AppColors.primary.s300.withValues(alpha: 0.1),
                  child: Center(
                    child: Icon(Icons.map,
                        size: 48,
                        color: AppColors.primary.s300.withValues(alpha: 0.5)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            map.name,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                        // Save Action
                        IconButton(
                          icon: const Icon(Icons.bookmark_border),
                          onPressed: () {
                            HapticFeedback
                                .mediumImpact(); // "Bookmark animation"
                            onSave();
                          },
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          visualDensity: VisualDensity.compact,
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      map.description ?? 'No description',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.neutral.s700,
                          ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    // Author & Follow
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 12,
                          backgroundColor:
                              AppColors.primary.s500.withValues(alpha: 0.2),
                          child: Text(
                            (map.authorName ?? 'U')[0].toUpperCase(),
                            style: TextStyle(
                                fontSize: 10, color: AppColors.primary.s500),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.xs),
                        Text(
                          map.authorName ?? 'Unknown',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const Spacer(),
                        // Follow Action
                        InkWell(
                          onTap: onFollow,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            child: Text(
                              'Follow',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    color: AppColors.primary.s500,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
