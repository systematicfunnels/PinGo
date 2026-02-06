import 'package:flutter/material.dart';
import 'package:pingo/core/theme/app_theme.dart';

enum PingoTextVariant {
  display,
  heading,
  body,
  caption,
}

enum PingoTextSize {
  small,
  medium,
  large,
}

class PingoText extends StatelessWidget {
  final String text;
  final PingoTextVariant variant;
  final PingoTextSize size;
  final bool isMuted;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final Color? color;

  const PingoText(
    this.text, {
    super.key,
    this.variant = PingoTextVariant.body,
    this.size = PingoTextSize.medium,
    this.isMuted = false,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.color,
  });

  const PingoText.display(
    this.text, {
    super.key,
    this.size = PingoTextSize.large, // Default to largest display
    this.isMuted = false,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.color,
  }) : variant = PingoTextVariant.display;

  const PingoText.heading(
    this.text, {
    super.key,
    this.size = PingoTextSize.medium,
    this.isMuted = false,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.color,
  }) : variant = PingoTextVariant.heading;

  const PingoText.body(
    this.text, {
    super.key,
    this.size = PingoTextSize.medium,
    this.isMuted = false,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.color,
  }) : variant = PingoTextVariant.body;

  const PingoText.caption(
    this.text, {
    super.key,
    this.isMuted = false,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.color,
  })  : variant = PingoTextVariant.caption,
        size = PingoTextSize.small;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final defaultColor =
        isMuted ? AppColors.neutral.s500 : AppColors.neutral.s900;

    TextStyle? style;

    switch (variant) {
      case PingoTextVariant.display:
        // Map Display sizes
        switch (size) {
          case PingoTextSize.large:
            style = theme.displayLarge;
            break;
          case PingoTextSize.medium:
            style = theme.displayMedium;
            break;
          case PingoTextSize.small:
            style = theme.displaySmall;
            break;
        }
        break;

      case PingoTextVariant.heading:
        // Map Heading sizes
        switch (size) {
          case PingoTextSize.large:
            style = theme.headlineLarge;
            break;
          case PingoTextSize.medium:
            style = theme.headlineMedium;
            break;
          case PingoTextSize.small:
            style = theme.headlineSmall;
            break;
        }
        break;

      case PingoTextVariant.body:
        // Map Body sizes
        switch (size) {
          case PingoTextSize.large:
            style = theme.bodyLarge;
            break;
          case PingoTextSize.medium:
            style = theme.bodyMedium;
            break;
          case PingoTextSize.small:
            style = theme.bodySmall;
            break;
        }
        break;

      case PingoTextVariant.caption:
        // Caption is usually small
        style = theme.labelSmall;
        break;
    }

    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      style: style?.copyWith(
        color: color ?? defaultColor,
      ),
    );
  }
}
