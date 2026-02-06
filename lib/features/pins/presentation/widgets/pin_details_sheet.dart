import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pingo/core/domain/models/pin_type.dart';
import 'package:pingo/core/theme/app_theme.dart';
import 'package:pingo/core/theme/spacing.dart';
import 'package:pingo/features/pins/domain/models/pin.dart';
import 'package:pingo/features/sharing/presentation/widgets/share_sheet.dart';
import '../controllers/pins_controller.dart';
import 'pin_editor_sheet.dart';

class PinDetailsSheet extends ConsumerWidget {
  final Pin pin;

  const PinDetailsSheet({super.key, required this.pin});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch for updates to this specific pin
    final pinsAsync = ref.watch(pinsControllerProvider);
    final livePin = pinsAsync.when(
      data: (pins) => pins.firstWhere(
        (p) => p.id == pin.id,
        orElse: () => pin,
      ),
      error: (_, __) => pin,
      loading: () => pin,
    );

    return Container(
      decoration: BoxDecoration(
        color: AppColors.neutral.s100,
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(AppSpacing.xl)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Drag Handle
            Center(
              child: Container(
                width: 32,
                height: 4,
                margin: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                decoration: BoxDecoration(
                  color: AppColors.neutral.s300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        livePin.type == PinType.safety
                            ? Icons.warning_amber_rounded
                            : Icons.place,
                        color: livePin.type == PinType.safety
                            ? AppColors.error.s500
                            : AppColors.primary.s500,
                        size: 28,
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: Text(
                          livePin.title ?? 'Untitled Pin',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                      // Share Action
                      IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (context) => ShareSheet(pin: livePin),
                          );
                        },
                        icon: Icon(Icons.share_outlined,
                            color: AppColors.neutral.s900),
                      ),
                      // Actions Menu
                      PopupMenuButton<String>(
                        onSelected: (value) async {
                          if (value == 'edit') {
                            context.pop(); // Close details
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (context) => PinEditorSheet(
                                pinToEdit: livePin,
                              ),
                            );
                          } else if (value == 'delete') {
                            final confirm = await showDialog<bool>(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Delete Pin?'),
                                content:
                                    const Text('This action cannot be undone.'),
                                actions: [
                                  TextButton(
                                    onPressed: () => context.pop(false),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () => context.pop(true),
                                    style: TextButton.styleFrom(
                                        foregroundColor: AppColors.error.s500),
                                    child: const Text('Delete'),
                                  ),
                                ],
                              ),
                            );

                            if (confirm == true) {
                              await ref
                                  .read(pinsControllerProvider.notifier)
                                  .deletePin(livePin.id);
                              if (context.mounted) {
                                context.pop(); // Close details
                              }
                            }
                          }
                        },
                        itemBuilder: (BuildContext context) =>
                            <PopupMenuEntry<String>>[
                          const PopupMenuItem<String>(
                            value: 'edit',
                            child: Row(
                              children: [
                                Icon(Icons.edit_outlined, size: 20),
                                SizedBox(width: AppSpacing.md),
                                Text('Edit'),
                              ],
                            ),
                          ),
                          PopupMenuItem<String>(
                            value: 'delete',
                            child: Row(
                              children: [
                                Icon(Icons.delete_outline,
                                    size: 20, color: AppColors.error.s500),
                                SizedBox(width: AppSpacing.md),
                                Text('Delete',
                                    style:
                                        TextStyle(color: AppColors.error.s500)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),
                  if (livePin.description != null &&
                      livePin.description!.isNotEmpty)
                    Text(
                      livePin.description!,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            height: 1.5,
                            color: AppColors.neutral.s700,
                          ),
                    ),
                  const SizedBox(height: AppSpacing.lg),

                  // Metadata Section
                  Row(
                    children: [
                      _MetadataChip(
                        icon: Icons.access_time,
                        label: _formatDate(livePin.createdAt),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      _MetadataChip(
                        icon: Icons.layers_outlined,
                        label: livePin.type.name.toUpperCase(),
                      ),
                    ],
                  ),

                  // Media Section (Placeholder for now)
                  if (livePin.mediaPaths.isNotEmpty) ...[
                    const SizedBox(height: AppSpacing.lg),
                    SizedBox(
                      height: 100,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: livePin.mediaPaths.length,
                        separatorBuilder: (_, __) =>
                            const SizedBox(width: AppSpacing.sm),
                        itemBuilder: (context, index) {
                          return Container(
                            width: 100,
                            decoration: BoxDecoration(
                              color: AppColors.neutral.s50,
                              borderRadius:
                                  BorderRadius.circular(AppSpacing.md),
                            ),
                            child: Icon(Icons.image,
                                color: AppColors.neutral.s500),
                          );
                        },
                      ),
                    ),
                  ],

                  const SizedBox(height: AppSpacing.xl),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}

class _MetadataChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _MetadataChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: AppColors.neutral.s50,
        borderRadius: BorderRadius.circular(AppSpacing.sm),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: AppColors.neutral.s500),
          const SizedBox(width: AppSpacing.xs),
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppColors.neutral.s500,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
  }
}
