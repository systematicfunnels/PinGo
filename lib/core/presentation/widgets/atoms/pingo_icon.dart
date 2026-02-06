import 'package:flutter/material.dart';
import 'package:pingo/core/theme/app_theme.dart';

enum PingoIconSize {
  small, // 16px
  medium, // 24px (Default)
  large, // 32px
  xlarge, // 48px
}

class PingoIcon extends StatelessWidget {
  final IconData icon;
  final PingoIconSize size;
  final bool isDisabled;
  final Color? color;

  const PingoIcon(
    this.icon, {
    super.key,
    this.size = PingoIconSize.medium,
    this.isDisabled = false,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final double iconSize = _getIconSize(size);
    final Color defaultColor =
        isDisabled ? AppColors.neutral.s300 : AppColors.neutral.s900;

    return Icon(
      icon,
      size: iconSize,
      color: color ?? defaultColor,
    );
  }

  double _getIconSize(PingoIconSize size) {
    switch (size) {
      case PingoIconSize.small:
        return 16.0;
      case PingoIconSize.medium:
        return 24.0;
      case PingoIconSize.large:
        return 32.0;
      case PingoIconSize.xlarge:
        return 48.0;
    }
  }
}
