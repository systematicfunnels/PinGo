import 'package:flutter/material.dart';
import 'package:pingo/core/theme/app_theme.dart';
import 'package:pingo/core/theme/radius.dart';
import 'package:pingo/core/theme/spacing.dart';
import 'package:pingo/core/presentation/widgets/atoms/atoms.dart';

enum PingoChipVariant {
  filter,
  tag,
  status,
}

class PingoChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback? onSelected;
  final PingoChipVariant variant;
  final bool isDisabled;
  final IconData? icon;

  const PingoChip({
    super.key,
    required this.label,
    this.isSelected = false,
    this.onSelected,
    this.variant = PingoChipVariant.filter,
    this.isDisabled = false,
    this.icon,
  });

  const PingoChip.filter({
    super.key,
    required this.label,
    this.isSelected = false,
    required this.onSelected,
    this.isDisabled = false,
    this.icon,
  }) : variant = PingoChipVariant.filter;

  const PingoChip.tag({
    super.key,
    required this.label,
    this.onSelected,
    this.isDisabled = false,
    this.icon,
  })  : variant = PingoChipVariant.tag,
        isSelected = false;

  const PingoChip.status({
    super.key,
    required this.label,
    this.isDisabled = false,
    this.icon,
  })  : variant = PingoChipVariant.status,
        isSelected = false,
        onSelected = null;

  @override
  Widget build(BuildContext context) {
    final colors = _getColors();
    final bgColor = colors.$1;
    final fgColor = colors.$2;
    final borderColor = colors.$3;

    return InkWell(
      onTap: isDisabled ? null : onSelected,
      borderRadius: AppRadius.allFull,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: AppRadius.allFull,
          border: Border.all(
            color: borderColor,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              PingoIcon(
                icon!,
                size: PingoIconSize.small,
                color: fgColor,
              ),
              const SizedBox(width: AppSpacing.xs),
            ],
            PingoText.body(
              label,
              size: PingoTextSize.small,
              color: fgColor,
            ),
          ],
        ),
      ),
    );
  }

  // Returns (Background, Foreground, Border)
  (Color, Color, Color) _getColors() {
    if (isDisabled) {
      return (
        AppColors.neutral.s100,
        AppColors.neutral.s300,
        AppColors.neutral.s300
      );
    }

    switch (variant) {
      case PingoChipVariant.filter:
        if (isSelected) {
          return (
            AppColors.primary.s500,
            AppColors.neutral.s100,
            AppColors.primary.s500
          );
        }
        return (
          AppColors.neutral.s100,
          AppColors.neutral.s900,
          AppColors.neutral.s300
        );
      case PingoChipVariant.tag:
        return (
          AppColors.neutral.s50,
          AppColors.neutral.s700,
          Colors.transparent
        );
      case PingoChipVariant.status:
        // Semantic status colors could be added here
        return (
          AppColors.info.s500.withValues(alpha: 0.1),
          AppColors.info.s500,
          Colors.transparent
        );
    }
  }
}
