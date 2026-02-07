import 'package:flutter/material.dart';
import 'package:pingo/core/theme/app_theme.dart';
import 'package:pingo/core/theme/radius.dart';
import 'package:pingo/core/presentation/widgets/atoms/atoms.dart';

class PingoIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final bool isDisabled;
  final Color? color;
  final Color? backgroundColor;
  final String? tooltip;

  const PingoIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.isDisabled = false,
    this.color,
    this.backgroundColor,
    this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveColor =
        isDisabled ? AppColors.neutral.s300 : (color ?? AppColors.neutral.s900);

    Widget button = InkWell(
      onTap: isDisabled ? null : onPressed,
      borderRadius: AppRadius.allFull,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: backgroundColor ?? Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: PingoIcon(
          icon,
          size: PingoIconSize.medium,
          color: effectiveColor,
          isDisabled: isDisabled,
        ),
      ),
    );

    if (tooltip != null) {
      button = Tooltip(
        message: tooltip,
        child: button,
      );
    }

    return button;
  }
}
