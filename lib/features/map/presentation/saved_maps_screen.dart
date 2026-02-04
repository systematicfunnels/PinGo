import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pingo/core/routing/route_paths.dart';
import 'package:pingo/core/theme/app_theme.dart';
import 'package:pingo/core/theme/spacing.dart';
import 'package:pingo/core/utils/date_utils.dart';
import 'package:pingo/features/map/presentation/saved_maps_controller.dart';

class SavedMapsScreen extends ConsumerWidget {
  const SavedMapsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapsAsync = ref.watch(savedMapsControllerProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Saved Maps'),
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => context.pop(),
        ),
      ),
      body: mapsAsync.when(
        data: (maps) {
          if (maps.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.map_outlined,
                      size: 64, color: AppColors.textTertiary),
                  const SizedBox(height: AppSpacing.lg),
                  Text(
                    'No saved maps yet',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    'Download regions for offline use',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textTertiary,
                        ),
                  ),
                ],
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
                  color: AppColors.danger,
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
                            child: const Text("Delete",
                                style: TextStyle(color: AppColors.danger)),
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
                child: Card(
                  elevation: 0,
                  color: AppColors.surface,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSpacing.md),
                    side: BorderSide(color: Colors.grey.withValues(alpha: 0.1)),
                  ),
                  child: ListTile(
                    contentPadding: AppSpacing.allLg,
                    leading: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(AppSpacing.sm),
                      ),
                      child: const Icon(Icons.map, color: AppColors.primary),
                    ),
                    title: Text(
                      region.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          '$sizeMb MB • ${AppDateUtils.formatDateTime(region.downloadedAt)}',
                          style: const TextStyle(color: AppColors.textTertiary),
                        ),
                      ],
                    ),
                    trailing: PopupMenuButton<String>(
                      icon: const Icon(Icons.more_vert,
                          color: AppColors.textSecondary),
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
                                  child: const Text('Delete',
                                      style:
                                          TextStyle(color: AppColors.danger)),
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
                        const PopupMenuItem(
                          value: 'rename',
                          child: Row(
                            children: [
                              Icon(Icons.edit,
                                  size: 18, color: AppColors.textSecondary),
                              SizedBox(width: AppSpacing.sm),
                              Text('Rename'),
                            ],
                          ),
                        ),
                        const PopupMenuItem(
                          value: 'delete',
                          child: Row(
                            children: [
                              Icon(Icons.delete,
                                  size: 18, color: AppColors.danger),
                              SizedBox(width: AppSpacing.sm),
                              Text('Delete',
                                  style: TextStyle(color: AppColors.danger)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          context.go(RoutePaths.regionSelection);
        },
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.download),
        label: const Text('Download New Region'),
      ),
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
