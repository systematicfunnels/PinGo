import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pingo/core/theme/app_theme.dart';
import 'package:pingo/core/theme/radius.dart';
import 'package:pingo/core/theme/spacing.dart';
import 'package:pingo/core/presentation/widgets/atoms/atoms.dart';

enum PingoButtonIntent {
  primary,
  secondary,
  ghost,
  destructive,
}

enum PingoButtonSize {
  sm,
  md,
  lg,
}

/// A molecule button component that implements the "Disabled vs Active States" rules.
///
/// Rules:
/// - Intents: Primary, Secondary, Ghost
/// - Disabled button (Missing permission): Not tappable, Muted color.
/// - Disabled action (Offline): Tap explains why, One-line toast.
/// - Active button: Haptic feedback.
/// - Loading (Short <1s): Inline progress, No spinner.
/// - Loading (Long >1s): Show progress text "Preparing...".
class PingoButton extends StatefulWidget {
  final String label;
  final VoidCallback? onPressed;
  final PingoButtonIntent intent;
  final PingoButtonSize size;
  final bool isDisabled;
  final String? disabledReason;
  final bool isLoading;
  final IconData? leadingIcon;
  final bool isFullWidth;

  const PingoButton({
    super.key,
    required this.label,
    this.onPressed,
    this.intent = PingoButtonIntent.primary,
    this.size = PingoButtonSize.md,
    this.isDisabled = false,
    this.disabledReason,
    this.isLoading = false,
    this.leadingIcon,
    this.isFullWidth = true,
  });

  const PingoButton.primary({
    super.key,
    required this.label,
    this.onPressed,
    this.size = PingoButtonSize.md,
    this.isDisabled = false,
    this.disabledReason,
    this.isLoading = false,
    this.leadingIcon,
    this.isFullWidth = true,
  }) : intent = PingoButtonIntent.primary;

  const PingoButton.secondary({
    super.key,
    required this.label,
    this.onPressed,
    this.size = PingoButtonSize.md,
    this.isDisabled = false,
    this.disabledReason,
    this.isLoading = false,
    this.leadingIcon,
    this.isFullWidth = true,
  }) : intent = PingoButtonIntent.secondary;

  const PingoButton.ghost({
    super.key,
    required this.label,
    this.onPressed,
    this.size = PingoButtonSize.md,
    this.isDisabled = false,
    this.disabledReason,
    this.isLoading = false,
    this.leadingIcon,
    this.isFullWidth = true,
  }) : intent = PingoButtonIntent.ghost;

  const PingoButton.destructive({
    super.key,
    required this.label,
    this.onPressed,
    this.size = PingoButtonSize.md,
    this.isDisabled = false,
    this.disabledReason,
    this.isLoading = false,
    this.leadingIcon,
    this.isFullWidth = true,
  }) : intent = PingoButtonIntent.destructive;

  @override
  State<PingoButton> createState() => _PingoButtonState();
}

class _PingoButtonState extends State<PingoButton> {
  Timer? _loadingTimer;
  bool _showLongLoading = false;

  @override
  void didUpdateWidget(covariant PingoButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isLoading && !oldWidget.isLoading) {
      _startLoadingTimer();
    } else if (!widget.isLoading && oldWidget.isLoading) {
      _stopLoadingTimer();
    }
  }

  void _startLoadingTimer() {
    _showLongLoading = false;
    _loadingTimer = Timer(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _showLongLoading = true;
        });
      }
    });
  }

  void _stopLoadingTimer() {
    _loadingTimer?.cancel();
    _loadingTimer = null;
    if (_showLongLoading) {
      setState(() {
        _showLongLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _loadingTimer?.cancel();
    super.dispose();
  }

  void _handlePress() {
    if (widget.isLoading) return;

    if (widget.isDisabled) {
      if (widget.disabledReason != null) {
        // "Disabled action | Offline limitation | Tap explains why | One-line toast"
        HapticFeedback.selectionClick(); // Subtle feedback for "rejection"
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(widget.disabledReason!),
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 2),
          ),
        );
      }
      // If disabledReason is null, it's "Not tappable" (Strictly Disabled)
      return;
    }

    // "Active button | Ready state | Immediate action | Haptic"
    HapticFeedback.lightImpact();
    widget.onPressed?.call();
  }

  @override
  Widget build(BuildContext context) {
    final colors = _getColors();
    final bgColor = colors.$1;
    final fgColor = colors.$2;
    final sizeParams = _getSizeParams();

    // Adjust opacity for disabled state if not handled by button style
    // For ghost buttons, we might want to just fade the text

    Widget content;
    if (widget.isLoading) {
      if (_showLongLoading) {
        // "Loading | Long (>1s) | Show progress text | 'Preparing...'"
        content = PingoText.body(
          "Preparing...",
          color: fgColor,
          size: sizeParams.textSize,
        );
      } else {
        // "Loading | Short (<1s) | Inline progress | No spinner"
        content = Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            PingoText.body(
              widget.label,
              color: fgColor,
              size: sizeParams.textSize,
            ),
            const SizedBox(height: 4),
            SizedBox(
              height: 2,
              width: 24,
              child: LinearProgressIndicator(
                color: fgColor,
                backgroundColor: Colors.transparent,
              ),
            ),
          ],
        );
      }
    } else {
      // Normal State
      if (widget.leadingIcon != null) {
        content = Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PingoIcon(widget.leadingIcon!,
                color: fgColor, size: sizeParams.iconSize),
            const SizedBox(width: AppSpacing.sm),
            PingoText.body(
              widget.label,
              color: fgColor,
              size: sizeParams.textSize,
            ),
          ],
        );
      } else {
        content = PingoText.body(
          widget.label,
          color: fgColor,
          size: sizeParams.textSize,
        );
      }
    }

    final buttonStyle = ElevatedButton.styleFrom(
      backgroundColor: bgColor,
      foregroundColor: fgColor,
      elevation: 0,
      padding: sizeParams.padding,
      minimumSize: Size(0, sizeParams.height),
      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.all8,
      ),
      // We handle disabled state manually to support tap-on-disabled
      disabledBackgroundColor: bgColor?.withValues(alpha: 0.5),
      disabledForegroundColor: fgColor.withValues(alpha: 0.5),
    );

    final button = SizedBox(
      width: widget.isFullWidth ? double.infinity : null,
      height: widget.isFullWidth ? sizeParams.height : null,
      child: ElevatedButton(
        onPressed: (widget.isLoading ||
                (widget.isDisabled && widget.disabledReason == null))
            ? null // Strictly disabled (no tap)
            : _handlePress, // Handle tap (even if disabled with reason)
        style: buttonStyle,
        child: content,
      ),
    );

    return button;
  }

  ({
    double height,
    EdgeInsets padding,
    PingoTextSize textSize,
    PingoIconSize iconSize
  }) _getSizeParams() {
    switch (widget.size) {
      case PingoButtonSize.sm:
        return (
          height: 32.0,
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          textSize: PingoTextSize.small,
          iconSize: PingoIconSize.small,
        );
      case PingoButtonSize.md:
        return (
          height: 48.0,
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          textSize: PingoTextSize.medium,
          iconSize: PingoIconSize.medium,
        );
      case PingoButtonSize.lg:
        return (
          height: 56.0,
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
          textSize: PingoTextSize.large,
          iconSize: PingoIconSize.medium,
        );
    }
  }

  // Returns (BackgroundColor, ForegroundColor)
  (Color?, Color) _getColors() {
    final isVisuallyDisabled = widget.isDisabled || widget.isLoading;

    if (isVisuallyDisabled) {
      // Disabled colors
      switch (widget.intent) {
        case PingoButtonIntent.primary:
          return (AppColors.neutral.s300, AppColors.neutral.s500);
        case PingoButtonIntent.secondary:
          return (AppColors.neutral.s100, AppColors.neutral.s300);
        case PingoButtonIntent.ghost:
          return (Colors.transparent, AppColors.neutral.s300);
        case PingoButtonIntent.destructive:
          return (AppColors.neutral.s100, AppColors.neutral.s300);
      }
    }

    switch (widget.intent) {
      case PingoButtonIntent.primary:
        return (AppColors.primary.s500, AppColors.neutral.s100);
      case PingoButtonIntent.secondary:
        return (AppColors.neutral.s300, AppColors.neutral.s900);
      case PingoButtonIntent.ghost:
        return (Colors.transparent, AppColors.primary.s500);
      case PingoButtonIntent.destructive:
        return (AppColors.error.s500, Colors.white);
    }
  }
}
