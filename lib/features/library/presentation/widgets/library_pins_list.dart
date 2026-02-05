import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pingo/core/domain/models/content_visibility.dart';
import 'package:pingo/core/theme/app_theme.dart';
import 'package:pingo/core/theme/spacing.dart';
import 'package:pingo/features/pins/presentation/controllers/pins_controller.dart';
import 'package:pingo/features/pins/presentation/widgets/pin_details_sheet.dart';

class LibraryPinsList extends ConsumerWidget {
  const LibraryPinsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pinsAsync = ref.watch(pinsControllerProvider);

    return pinsAsync.when(
      data: (pins) {
        if (pins.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.place_outlined,
                  size: 64,
                  color: AppColors.neutral.s500.withOpacity(0.5),
                )
                const SizedBox(height: AppSpacing.lg),
                Text(
                  'No pins yet.\nStart your journey to add some memories.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.neutral.s700,
                      ),
                ),
              ],
            ),
          );
        }
        return ListView.separated(
          padding: AppSpacing.allLg,
          itemCount: pins.length,
          separatorBuilder: (context, index) =>
              const SizedBox(height: AppSpacing.md),
          itemBuilder: (context, index) {
            final pin = pins[index];
            return Dismissible(
              key: ValueKey(pin.id),
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
                      title: const Text("Confirm Delete"),
                      content: const Text(
                          "Are you sure you want to delete this pin?"),
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
                ref.read(pinsControllerProvider.notifier).deletePin(pin.id);
              },
              child: Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: AppColors.primary.s300.withOpacity(0.2),
                    child: Icon(Icons.place, color: AppColors.primary.s300),
                  ),
                  title: Row(
                    children: [
                      Expanded(
                        child: Text(
                          pin.title ?? 'Untitled Pin',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      Icon(
                        _getVisibilityIcon(pin.visibility),
                        size: AppSpacing.lg,
                        color: AppColors.neutral.s500,
                      ),
                    ],
                  ),
                  subtitle: Text(
                    pin.description ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) => PinDetailsSheet(pin: pin),
                    );
                  },
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
