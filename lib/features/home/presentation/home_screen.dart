import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pingo/core/presentation/widgets/atoms/atoms.dart';
import 'package:pingo/core/routing/route_paths.dart';
import 'package:pingo/core/theme/app_theme.dart';
import 'package:pingo/core/theme/elevation.dart';
import 'package:pingo/core/theme/radius.dart';
import 'package:pingo/core/theme/spacing.dart';
import 'package:pingo/core/utils/date_utils.dart';
import 'package:pingo/core/utils/geo_utils.dart';
import 'package:pingo/features/pins/presentation/controllers/pins_controller.dart';
import 'package:pingo/features/pins/presentation/widgets/pin_details_sheet.dart';
import 'package:pingo/core/presentation/widgets/organisms/pingo_empty_state.dart';
import 'package:pingo/features/route_recording/presentation/controllers/record_controller.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recordState = ref.watch(recordControllerProvider);

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Gentle Header
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                    AppSpacing.lg, AppSpacing.xl, AppSpacing.lg, AppSpacing.md),
                child: _HomeHeader(),
              ),
            ),

            // Continue Journey (Conditional)
            if (recordState.isRecording)
              SliverToBoxAdapter(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                  child: _ActiveJourneyCard(
                    duration: recordState.duration,
                    distance: recordState.distance,
                    onTap: () => context.go(RoutePaths.create),
                  ),
                ),
              ),

            // Soft Prompts
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.lg, vertical: AppSpacing.md),
                child: Row(
                  children: [
                    Expanded(
                      child: _SoftPromptCard(
                        icon: Icons.push_pin_outlined,
                        label: 'Pin a moment',
                        onTap: () {
                          context
                              .go('${RoutePaths.create}/${RoutePaths.addPin}');
                        },
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: _SoftPromptCard(
                        icon: Icons.visibility_off_outlined,
                        label: 'Explore quietly',
                        onTap: () {
                          context.go(RoutePaths.explore);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Feed Section
            const SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              sliver: _FeedSection(),
            ),

            // Bottom Spacer
            const SliverToBoxAdapter(
              child: SizedBox(height: AppSpacing.xxl),
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeHeader extends StatelessWidget {
  const _HomeHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PingoText.body(
          AppDateUtils.getGreeting(DateTime.now()),
          color: AppColors.neutral.s700,
          size: PingoTextSize.large,
        ),
        const SizedBox(height: AppSpacing.xs),
        const PingoText.heading(
          'Ready to explore?',
          size: PingoTextSize.medium,
        ),
      ],
    );
  }
}

class _ActiveJourneyCard extends StatelessWidget {
  final Duration duration;
  final double distance;
  final VoidCallback onTap;

  const _ActiveJourneyCard({
    required this.duration,
    required this.distance,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primary.s500.withValues(alpha: 0.05),
        borderRadius: AppRadius.all12,
        boxShadow: AppElevation.card,
        border:
            Border.all(color: AppColors.primary.s500.withValues(alpha: 0.1)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: AppRadius.all12,
          child: Padding(
            padding: AppSpacing.allLg,
            child: Row(
              children: [
                Container(
                  padding: AppSpacing.allSm,
                  decoration: BoxDecoration(
                    color: AppColors.primary.s500,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.directions_walk,
                      color: Colors.white, size: 20),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PingoText.heading(
                        'Recording Journey',
                        size: PingoTextSize.small,
                        color: AppColors.primary.s500,
                      ),
                      const SizedBox(height: 2),
                      PingoText.body(
                        '${GeoUtils.formatDistance(distance)} • ${AppDateUtils.formatDuration(duration)}',
                        size: PingoTextSize.small,
                      ),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right, color: AppColors.neutral.s500),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SoftPromptCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _SoftPromptCard({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.neutral.s100,
        borderRadius: AppRadius.all12,
        boxShadow: AppElevation.card,
        border: Border.all(color: AppColors.neutral.s300),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: AppRadius.all12,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: AppSpacing.md,
              horizontal: AppSpacing.md,
            ),
            child: Column(
              children: [
                Icon(icon, color: AppColors.neutral.s700, size: 24),
                const SizedBox(height: AppSpacing.xs),
                PingoText.body(
                  label,
                  color: AppColors.neutral.s700,
                  size: PingoTextSize.small,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FeedSection extends ConsumerWidget {
  const _FeedSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pinsAsync = ref.watch(pinsControllerProvider);

    return pinsAsync.when(
      data: (pins) {
        if (pins.isEmpty) {
          return SliverToBoxAdapter(
            child: PingoEmptyState.explore(
              title: 'Your feed is quiet',
              subtitle: 'Start a journey or explore maps to see activity here.',
              action: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton.icon(
                    onPressed: () => context.go(RoutePaths.explore),
                    icon: const Icon(Icons.explore_outlined),
                    label: const Text('Explore maps'),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  TextButton.icon(
                    onPressed: () => context.go(RoutePaths.create),
                    icon: const Icon(Icons.directions_walk),
                    label: const Text('Start journey'),
                  ),
                ],
              ),
            ),
          );
        }

        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final pin = pins[index];
              return Card(
                margin: const EdgeInsets.only(bottom: AppSpacing.md),
                child: ListTile(
                  leading: const CircleAvatar(child: Icon(Icons.place)),
                  title: PingoText.body(pin.title ?? 'Untitled Pin',
                      size: PingoTextSize.medium),
                  subtitle: PingoText.body(pin.description ?? '',
                      size: PingoTextSize.small, isMuted: true),
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) => PinDetailsSheet(pin: pin),
                    );
                  },
                ),
              );
            },
            childCount: pins.length,
          ),
        );
      },
      loading: () => const SliverToBoxAdapter(
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (err, stack) => SliverToBoxAdapter(
        child: Center(child: Text('Error loading feed: $err')),
      ),
    );
  }
}
