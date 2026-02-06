import 'package:flutter/material.dart';
import 'package:pingo/core/theme/app_theme.dart';
import 'package:pingo/core/theme/spacing.dart';
import 'package:pingo/core/presentation/widgets/pingo_button.dart';

class ShareConfirmationDialog extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback onConfirm;
  final bool isPublic;

  const ShareConfirmationDialog({
    super.key,
    required this.title,
    required this.content,
    required this.onConfirm,
    this.isPublic = false,
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
                borderRadius: BorderRadius.circular(AppSpacing.sm),
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
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        PingoButton(
          onPressed: () {
            onConfirm();
            Navigator.of(context).pop();
          },
          label: 'Confirm Share',
          isFullWidth: false,
        ),
      ],
    );
  }
}
