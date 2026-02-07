import 'package:flutter/material.dart';
import 'package:pingo/core/theme/app_theme.dart';

class PingoFab extends StatelessWidget {
  final VoidCallback onPressed;
  final String? label;
  final IconData icon;
  final bool isExtended;

  const PingoFab({
    super.key,
    required this.onPressed,
    required this.icon,
    this.label,
    this.isExtended = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isExtended && label != null) {
      return FloatingActionButton.extended(
        onPressed: onPressed,
        icon: Icon(icon),
        label: Text(label!),
        backgroundColor: AppColors.primary.s500,
        foregroundColor: AppColors.neutral.s100,
        elevation: 4,
      );
    }

    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: AppColors.primary.s500,
      foregroundColor: AppColors.neutral.s100,
      elevation: 4,
      child: Icon(icon),
    );
  }
}
