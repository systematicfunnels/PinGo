import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pingo/core/domain/models/content_visibility.dart';
import 'package:pingo/core/routing/route_paths.dart';
import 'package:pingo/core/theme/app_theme.dart';
import 'package:pingo/core/theme/spacing.dart';
import 'package:pingo/core/utils/date_utils.dart';
import 'package:pingo/features/map/presentation/user_maps_controller.dart';
import 'package:pingo/features/map/presentation/widgets/share_map_sheet.dart';

import 'package:pingo/shared/widgets/empty_state.dart';

class UserMapsList extends ConsumerWidget {
  const UserMapsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapsAsync = ref.watch(userMapsControllerProvider);

    return mapsAsync.when(
      data: (maps) {
        if (maps.isEmpty) {
          return const EmptyState(
            icon: Icons.map_outlined,
            title: 'No created maps yet',
            subtitle: 'Start a journey or create a map to see it here',
          );
        }

        return ListView.separated(
          padding: AppSpacing.allLg,
          itemCount: maps.length,
          separatorBuilder: (context, index) =>
              const SizedBox(height: AppSpacing.md),
          itemBuilder: (context, index) {
            final map = maps[index];
            return Card(
              elevation: 0,
              color: AppColors.neutral.s100,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSpacing.md),
                side: BorderSide(color: AppColors.neutral.s300),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.all(AppSpacing.md),
                leading: Container(
                  padding: AppSpacing.allMd,
                  decoration: BoxDecoration(
                    color: AppColors.primary.s500.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.map, color: AppColors.primary.s500),
                ),
                title: Text(
                  map.name,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (map.authorName != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: Text(
                          'by ${map.authorName}',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: AppColors.primary.s500,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                      ),
                    if (map.description != null && map.description!.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          map.description!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          map.visibility == ContentVisibility.private
                              ? Icons.lock_outline
                              : Icons.public,
                          size: 14,
                          color: AppColors.neutral.s500,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          map.visibility == ContentVisibility.private
                              ? 'Private'
                              : 'Shared',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: AppColors.neutral.s500,
                                  ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '• ${AppDateUtils.formatDate(map.createdAt)}',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: AppColors.neutral.s500,
                                  ),
                        ),
                      ],
                    ),
                  ],
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.share_outlined),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) => ShareMapSheet(map: map),
                    );
                  },
                ),
                onTap: () {
                  context.pushNamed(
                    RoutePaths.mapPreview,
                    pathParameters: {'id': map.id.toString()},
                  );
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
}
