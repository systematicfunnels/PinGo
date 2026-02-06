import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pingo/core/theme/app_theme.dart';
import 'package:pingo/core/theme/elevation.dart';
import 'package:pingo/core/theme/radius.dart';
import 'package:pingo/core/theme/spacing.dart';
import 'package:pingo/core/domain/models/content_visibility.dart';
import 'package:pingo/core/utils/date_utils.dart';
import 'package:pingo/core/utils/geo_utils.dart';
import 'package:pingo/features/route_recording/data/repositories/journey_repository_impl.dart';

class JourneyList extends ConsumerWidget {
  const JourneyList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final journeysAsync = ref.watch(allJourneysProvider);

    return journeysAsync.when(
      data: (journeys) {
        if (journeys.isEmpty) {
          return const Center(child: Text('No journeys recorded yet.'));
        }
        return ListView.builder(
          padding: AppSpacing.allLg,
          itemCount: journeys.length,
          itemBuilder: (context, index) {
            final journey = journeys[index];
            return Container(
              margin: const EdgeInsets.only(bottom: AppSpacing.md),
              padding: AppSpacing.allMd,
              decoration: BoxDecoration(
                color: AppColors.neutral.s100,
                borderRadius: AppRadius.all12,
                boxShadow: AppElevation.card,
              ),
              child: ListTile(
                contentPadding: AppSpacing.allLg,
                leading: Container(
                  padding: AppSpacing.allMd,
                  decoration: BoxDecoration(
                    color: AppColors.primary.s500.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.directions_walk,
                      color: AppColors.primary.s500),
                ),
                title: Row(
                  children: [
                    Expanded(
                      child: Text(
                        journey.name ?? 'Untitled Journey',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Icon(
                      _getVisibilityIcon(journey.visibility),
                      size: 14,
                      color: AppColors.neutral.s500,
                    ),
                  ],
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: AppSpacing.xs),
                    Text(AppDateUtils.formatDateTime(journey.startTime)),
                    const SizedBox(height: AppSpacing.xs),
                    Row(
                      children: [
                        Icon(Icons.straighten,
                            size: 14, color: AppColors.neutral.s700),
                        const SizedBox(width: AppSpacing.xs),
                        Text(
                          GeoUtils.formatDistance(journey.totalDistance),
                          style: TextStyle(color: AppColors.neutral.s700),
                        ),
                        const SizedBox(width: AppSpacing.lg),
                        Icon(Icons.timer_outlined,
                            size: 14, color: AppColors.neutral.s700),
                        const SizedBox(width: AppSpacing.xs),
                        Text(
                          AppDateUtils.formatDuration(
                              Duration(seconds: journey.durationSeconds)),
                          style: TextStyle(color: AppColors.neutral.s700),
                        ),
                      ],
                    ),
                  ],
                ),
                onTap: () {
                  context.go('/library/journey/${journey.id}');
                },
              ),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Error: $err')),
    );
  }

  IconData _getVisibilityIcon(ContentVisibility visibility) {
    switch (visibility) {
      case ContentVisibility.private:
        return Icons.lock_outline;
      case ContentVisibility.trusted:
        return Icons.people_outline;
      case ContentVisibility.public:
        return Icons.public;
    }
  }
}

final allJourneysProvider = StreamProvider.autoDispose((ref) {
  final repo = ref.watch(journeyRepositoryProvider);
  return repo.watchAllJourneys();
});
