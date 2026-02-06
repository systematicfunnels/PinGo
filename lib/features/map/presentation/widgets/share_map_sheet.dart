import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pingo/core/domain/models/content_visibility.dart';
import 'package:pingo/core/presentation/widgets/molecules/pingo_button.dart';
import 'package:pingo/core/presentation/utils/snackbar_utils.dart';
import 'package:pingo/core/presentation/widgets/visibility_selector.dart';
import 'package:pingo/core/theme/app_theme.dart';
import 'package:pingo/core/theme/radius.dart';
import 'package:pingo/core/theme/spacing.dart';
import 'package:pingo/features/map/domain/map_entity.dart';
import 'package:pingo/features/map/presentation/user_maps_controller.dart';
import 'package:pingo/features/sharing/presentation/share_controller.dart';
import 'package:pingo/features/sharing/domain/visibility_rules.dart';

class ShareMapSheet extends ConsumerStatefulWidget {
  final UserMap map;

  const ShareMapSheet({super.key, required this.map});

  @override
  ConsumerState<ShareMapSheet> createState() => _ShareMapSheetState();
}

class _ShareMapSheetState extends ConsumerState<ShareMapSheet> {
  late ContentVisibility _visibility;
  late TextEditingController _noteController;

  @override
  void initState() {
    super.initState();
    _visibility = widget.map.visibility;
    _noteController = TextEditingController(text: widget.map.description);
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _handleShare() async {
    // Capture values
    final updatedMap = widget.map.copyWith(
      visibility: _visibility,
      description: _noteController.text.isEmpty ? null : _noteController.text,
    );
    final isPrivate = _visibility == ContentVisibility.private;

    // OPTIMISTIC UI
    if (mounted) {
      // Show success feedback
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(isPrivate
              ? 'Map is now private.'
              : 'Map settings updated for sharing.'),
          action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              // Undo logic triggers another background update
              ref
                  .read(userMapsControllerProvider.notifier)
                  .updateMap(widget.map);
            },
          ),
        ),
      );
      context.pop();
    }

    // Background Task
    Future(() async {
      try {
        // Update map visibility and description
        await ref
            .read(userMapsControllerProvider.notifier)
            .updateMap(updatedMap);

        if (VisibilityRules.canShare(_visibility)) {
          await ref.read(shareControllerProvider.notifier).shareMap(updatedMap);
        }
      } catch (e) {
        debugPrint('Background share update failed: $e');
        SnackbarUtils.showError(e);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      decoration: BoxDecoration(
        color: AppColors.neutral.s100,
        borderRadius: AppRadius.top16,
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: AppSpacing.allXl,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Share Map',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => context.pop(),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                'Control who can see "${widget.map.name}"',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.neutral.s700,
                    ),
              ),
              const SizedBox(height: AppSpacing.xl),

              // Visibility Selector
              Text(
                'Visibility',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: AppSpacing.sm),
              VisibilitySelector(
                selected: _visibility,
                onChanged: (v) => setState(() => _visibility = v),
              ),
              const SizedBox(height: AppSpacing.lg),

              // Context/Note
              Text(
                'Add Context (Optional)',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: AppSpacing.sm),
              TextField(
                controller: _noteController,
                decoration: InputDecoration(
                  hintText: 'Add a note about this map...',
                  filled: true,
                  fillColor: AppColors.neutral.s50,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppSpacing.md),
                    borderSide: BorderSide.none,
                  ),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: AppSpacing.xl),

              // Action Button
              PingoButton.primary(
                onPressed: _handleShare,
                isLoading: false,
                label: _visibility == ContentVisibility.private
                    ? 'Save Changes'
                    : 'Update & Share',
              ),
              if (_visibility != ContentVisibility.private) ...[
                const SizedBox(height: AppSpacing.md),
                Container(
                  padding: AppSpacing.allMd,
                  decoration: BoxDecoration(
                    color: AppColors.info.s500.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(AppSpacing.md),
                    border: Border.all(
                      color: AppColors.info.s500.withValues(alpha: 0.2),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.privacy_tip_outlined,
                          size: 16, color: AppColors.info.s500),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: Text(
                          'Sharing publicly will make this map visible to everyone. Avoid sharing home locations.',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: AppColors.info.s500,
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
