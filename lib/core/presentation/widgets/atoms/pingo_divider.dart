import 'package:flutter/material.dart';
import 'package:pingo/core/theme/app_theme.dart';

enum PingoDividerVariant {
  horizontal,
  vertical,
}

class PingoDivider extends StatelessWidget {
  final PingoDividerVariant variant;
  final double? thickness;
  final double? indent;
  final double? endIndent;
  final Color? color;

  const PingoDivider({
    super.key,
    this.variant = PingoDividerVariant.horizontal,
    this.thickness,
    this.indent,
    this.endIndent,
    this.color,
  });

  const PingoDivider.horizontal({
    super.key,
    this.thickness,
    this.indent,
    this.endIndent,
    this.color,
  }) : variant = PingoDividerVariant.horizontal;

  const PingoDivider.vertical({
    super.key,
    this.thickness,
    this.indent,
    this.endIndent,
    this.color,
  }) : variant = PingoDividerVariant.vertical;

  @override
  Widget build(BuildContext context) {
    final dividerColor = color ?? AppColors.neutral.s300;

    if (variant == PingoDividerVariant.vertical) {
      return VerticalDivider(
        color: dividerColor,
        thickness: thickness ?? 1.0,
        indent: indent,
        endIndent: endIndent,
        width: thickness ?? 1.0, // Minimal width for vertical divider
      );
    }

    return Divider(
      color: dividerColor,
      thickness: thickness ?? 1.0,
      indent: indent,
      endIndent: endIndent,
      height: thickness ?? 1.0, // Minimal height for horizontal divider
    );
  }
}
