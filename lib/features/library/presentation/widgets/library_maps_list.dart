import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pingo/core/presentation/widgets/molecules/pingo_button.dart';
import 'package:pingo/core/presentation/widgets/organisms/pingo_empty_state.dart';
import 'package:pingo/core/routing/route_paths.dart';
import 'package:pingo/core/theme/app_theme.dart';
import 'package:pingo/core/theme/elevation.dart';
import 'package:pingo/core/theme/radius.dart';
import 'package:pingo/core/theme/spacing.dart';
import 'package:pingo/core/utils/date_utils.dart';
import 'package:pingo/features/map/presentation/saved_maps_controller.dart';

class LibraryMapsList extends ConsumerWidget {
  const LibraryMapsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapsAsync = ref.watch(savedMapsControllerProvider);

    return mapsAsync.when(
      data: (maps) {
        if (maps.isEmpty) {
          return PingoEmptyState.library(
            title: 'No saved maps yet',
            subtitle: 'Download regions for offline use',
            action: PingoButton.secondary(
              onPressed: () {
                context.go(RoutePaths.regionSelection);
              },
              leadingIcon: Icons.download,
              label: 'Download New Region',
              isFullWidth: false,
            ),
          );
        }

        return ListView.separated(
          padding: AppSpacing.allLg,
          itemCount: maps.length,
          separatorBuilder: (context, index) =>
              const SizedBox(height: AppSpacing.md),
          itemBuilder: (context, index) {
            final region = maps[index];
            final sizeMb =
                (region.sizeBytes / (1024 * 1024)).toStringAsFixed(1);

            return Dismissible(
              key: ValueKey(region.id),
              direction: DismissDirection.endToStart,
              background: Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: AppSpacing.lg),
                color: AppColors.error.s500,
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              confirmDismiss: (direction) async {
                return await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Delete Map Region"),
                      content: const Text(
                          "Are you sure you want to delete this downloaded map? You will need to download it again to use it offline."),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: const Text("Cancel"),
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          child: Text("Delete",
                              style: TextStyle(color: AppColors.error.s500)),
                        ),
                      ],
                    );
                  },
                );
              },
              onDismissed: (_) {
                ref
                    .read(savedMapsControllerProvider.notifier)
                    .deleteRegion(region.id);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.neutral.s100,
                  borderRadius: AppRadius.all12,
                  boxShadow: AppElevation.card,
                  border: Border.all(
                      color: AppColors.neutral.s500.withValues(alpha: 0.1)),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: ListTile(
                    shape: const RoundedRectangleBorder(
                      borderRadius: AppRadius.all12,
                    ),
                    contentPadding: AppSpacing.allLg,
                    leading: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: AppColors.primary.s500.withValues(alpha: 0.1),
                        borderRadius: AppRadius.all8,
                      ),
                      child: Icon(Icons.map, color: AppColors.primary.s500),
                    ),
                    title: Text(
                      region.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.neutral.s900,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          '$sizeMb MB • ${AppDateUtils.formatDateTime(region.downloadedAt)}',
                          style: TextStyle(color: AppColors.neutral.s500),
                        ),
                      ],
                    ),
                    trailing: PopupMenuButton<String>(
                      icon:
                          Icon(Icons.more_vert, color: AppColors.neutral.s700),
                      onSelected: (value) async {
                        if (value == 'delete') {
                          final confirm = await showDialog<bool>(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Delete Map Region'),
                              content: const Text(
                                  'Are you sure you want to delete this downloaded map?'),
                              actions: [
                                TextButton(
                                  onPressed: () => context.pop(false),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () => context.pop(true),
                                  child: Text('Delete',
                                      style: TextStyle(
                                          color: AppColors.error.s500)),
                                ),
                              ],
                            ),
                          );
                          if (confirm == true) {
                            ref
                                .read(savedMapsControllerProvider.notifier)
                                .deleteRegion(region.id);
                          }
                        } else if (value == 'rename') {
                          _showRenameDialog(
                              context, ref, region.id, region.name);
                        }
                      },
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: 'rename',
                          child: Row(
                            children: [
                              Icon(Icons.edit,
                                  size: 18, color: AppColors.neutral.s700),
                              SizedBox(width: AppSpacing.sm),
                              Text('Rename'),
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          value: 'delete',
                          child: Row(
                            children: [
                              Icon(Icons.delete,
                                  size: 18, color: AppColors.error.s500),
                              SizedBox(width: AppSpacing.sm),
                              Text('Delete',
                                  style:
                                      TextStyle(color: AppColors.error.s500)),
                            ],
                          ),
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

  void _showRenameDialog(
      BuildContext context, WidgetRef ref, String id, String currentName) {
    final controller = TextEditingController(text: currentName);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Rename Map'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(labelText: 'Name'),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              ref
                  .read(savedMapsControllerProvider.notifier)
                  .renameRegion(id, controller.text.trim());
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
