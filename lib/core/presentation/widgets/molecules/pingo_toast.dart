import 'package:flutter/material.dart';
import 'package:pingo/core/theme/app_theme.dart';
import 'package:pingo/core/theme/radius.dart';
import 'package:pingo/core/theme/spacing.dart';
import 'package:pingo/core/presentation/widgets/atoms/atoms.dart';

enum PingoToastVariant {
  info,
  success,
  error,
}

class PingoToast extends StatelessWidget {
  final String message;
  final PingoToastVariant variant;
  final String? actionLabel;
  final VoidCallback? onAction;

  const PingoToast({
    super.key,
    required this.message,
    this.variant = PingoToastVariant.info,
    this.actionLabel,
    this.onAction,
  });

  const PingoToast.info(
    this.message, {
    super.key,
    this.actionLabel,
    this.onAction,
  }) : variant = PingoToastVariant.info;

  const PingoToast.success(
    this.message, {
    super.key,
    this.actionLabel,
    this.onAction,
  }) : variant = PingoToastVariant.success;

  const PingoToast.error(
    this.message, {
    super.key,
    this.actionLabel,
    this.onAction,
  }) : variant = PingoToastVariant.error;

  @override
  Widget build(BuildContext context) {
    final colors = _getColors();
    final bgColor = colors.$1;
    final fgColor = colors.$2;
    final icon = _getIcon();

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: AppRadius.all8,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          PingoIcon(
            icon,
            color: fgColor,
            size: PingoIconSize.small,
          ),
          const SizedBox(width: AppSpacing.md),
          Flexible(
            child: PingoText.body(
              message,
              color: fgColor,
              size: PingoTextSize.small,
            ),
          ),
          if (actionLabel != null && onAction != null) ...[
            const SizedBox(width: AppSpacing.lg),
            GestureDetector(
              onTap: onAction,
              child: PingoText.body(
                actionLabel!,
                color: fgColor,
                size: PingoTextSize.small,
              ), // Make it bold or distinct?
            ),
          ],
        ],
      ),
    );
  }

  (Color, Color) _getColors() {
    switch (variant) {
      case PingoToastVariant.info:
        return (AppColors.neutral.s900, AppColors.neutral.s100);
      case PingoToastVariant.success:
        return (AppColors.success.s500, AppColors.neutral.s100);
      case PingoToastVariant.error:
        return (AppColors.error.s500, AppColors.neutral.s100);
    }
  }

  IconData _getIcon() {
    switch (variant) {
      case PingoToastVariant.info:
        return Icons.info_outline;
      case PingoToastVariant.success:
        return Icons.check_circle_outline;
      case PingoToastVariant.error:
        return Icons.error_outline;
    }
  }
}
