import 'package:flutter/material.dart';
import 'package:pingo/core/presentation/widgets/molecules/pingo_button.dart';
import 'package:pingo/core/theme/app_theme.dart';
import 'package:pingo/core/theme/radius.dart';
import 'package:pingo/core/theme/spacing.dart';

class PingoConfirmationDialog extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback onConfirm;
  final bool isPublic;
  final String confirmLabel;
  final bool isDestructive;
  final String cancelLabel;

  const PingoConfirmationDialog({
    super.key,
    required this.title,
    required this.content,
    required this.onConfirm,
    this.isPublic = false,
    this.confirmLabel = 'Confirm',
    this.cancelLabel = 'Cancel',
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(content),
          if (isPublic) ...[
            const SizedBox(height: AppSpacing.lg),
            Container(
              padding: AppSpacing.allMd,
              decoration: BoxDecoration(
                color: AppColors.warning.s500.withValues(alpha: 0.1),
                borderRadius: AppRadius.all8,
                border: Border.all(color: AppColors.warning.s500),
              ),
              child: Row(
                children: [
                  Icon(Icons.public, color: AppColors.warning.s500),
                  SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Text(
                      'This will be visible to everyone in the community.',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
      actions: [
        PingoButton.ghost(
          onPressed: () => Navigator.of(context).pop(),
          label: cancelLabel,
          size: PingoButtonSize.sm,
          isFullWidth: false,
        ),
        isDestructive
            ? PingoButton.destructive(
                onPressed: () {
                  onConfirm();
                  Navigator.of(context).pop();
                },
                label: confirmLabel,
                size: PingoButtonSize.sm,
                isFullWidth: false,
              )
            : PingoButton.primary(
                onPressed: () {
                  onConfirm();
                  Navigator.of(context).pop();
                },
                label: confirmLabel,
                size: PingoButtonSize.sm,
                isFullWidth: false,
              ),
      ],
    );
  }
}
