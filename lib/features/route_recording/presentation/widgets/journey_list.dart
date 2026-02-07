import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pingo/core/theme/app_theme.dart';
import 'package:pingo/core/domain/models/content_visibility.dart';
import 'package:pingo/core/utils/date_utils.dart';
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
          padding: const EdgeInsets.all(16),
          itemCount: journeys.length,
          itemBuilder: (context, index) {
            final journey = journeys[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    context.go('/library/journey/${journey.id}');
                  },
                  borderRadius: BorderRadius.circular(16),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    journey.name ?? 'Untitled Collection',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(
                                          fontFamily: 'Serif',
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.textPrimary,
                                        ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    AppDateUtils.formatDateTime(journey.startTime),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          color: AppColors.textSecondary,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                            Icon(
                              Icons.chevron_right,
                              color: AppColors.textTertiary.withValues(alpha: 0.5),
                            ),
                          ],
                        ),
                        
                        const SizedBox(height: 16),
                        
                        // Fake "Days" Summary (using actual journey data)
                        _buildSummaryRow(
                          context,
                          Icons.grid_view,
                          'Day 1',
                          '${(journey.durationSeconds / 60).toStringAsFixed(0)} mins',
                        ),
                        
                        const SizedBox(height: 16),
                        Divider(height: 1, color: AppColors.border.withValues(alpha: 0.5)),
                        const SizedBox(height: 16),
                        
                        // Stats Footer
                        Row(
                          children: [
                            Icon(Icons.map_outlined, size: 16, color: AppColors.textSecondary),
                            const SizedBox(width: 6),
                            Text(
                              '${(journey.totalDistance / 1000).toStringAsFixed(2)} km',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                            const Spacer(),
                             Icon(
                              _getVisibilityIcon(journey.visibility),
                              size: 16,
                              color: AppColors.textTertiary,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Error: $err')),
    );
  }


  Widget _buildSummaryRow(BuildContext context, IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppColors.textTertiary.withValues(alpha: 0.5)),
        const SizedBox(width: 8),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppColors.textTertiary,
          ),
        ),
      ],
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
