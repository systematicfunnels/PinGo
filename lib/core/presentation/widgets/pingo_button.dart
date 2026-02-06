import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pingo/core/theme/app_theme.dart';
import 'package:pingo/core/theme/spacing.dart';

/// A global button component that implements the "Disabled vs Active States" rules.
///
/// Rules:
/// - Disabled button (Missing permission): Not tappable, Muted color.
/// - Disabled action (Offline): Tap explains why, One-line toast.
/// - Active button: Haptic feedback.
/// - Loading (Short <1s): Inline progress, No spinner.
/// - Loading (Long >1s): Show progress text "Preparing...".
class PingoButton extends StatefulWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isDisabled;
  final String? disabledReason;
  final bool isLoading;
  final IconData? icon;
  final bool isFullWidth;
  final Color? backgroundColor;
  final Color? foregroundColor;

  const PingoButton({
    super.key,
    required this.label,
    this.onPressed,
    this.isDisabled = false,
    this.disabledReason,
    this.isLoading = false,
    this.icon,
    this.isFullWidth = true,
    this.backgroundColor,
    this.foregroundColor,
  });

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
    final theme = Theme.of(context);
    final bgColor = widget.backgroundColor ?? AppColors.primary.s500;
    final fgColor = widget.foregroundColor ?? AppColors.neutral.s100;

    // Visual State: Disabled
    // "Disabled button | ... | Muted color"
    final isVisuallyDisabled = widget.isDisabled || widget.isLoading;
    final effectiveBgColor = isVisuallyDisabled
        ? AppColors.neutral.s500.withValues(alpha: 0.3)
        : bgColor;
    final effectiveFgColor =
        isVisuallyDisabled ? AppColors.neutral.s500 : fgColor;

    Widget content;
    if (widget.isLoading) {
      if (_showLongLoading) {
        // "Loading | Long (>1s) | Show progress text | 'Preparing...'"
        content = Text(
          "Preparing...",
          style: theme.textTheme.labelLarge?.copyWith(color: effectiveFgColor),
        );
      } else {
        // "Loading | Short (<1s) | Inline progress | No spinner"
        // Using a linear progress indicator at the bottom or similar.
        // Or just the label with an opacity animation?
        // "Inline progress" often implies a small bar.
        content = Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.label,
              style:
                  theme.textTheme.labelLarge?.copyWith(color: effectiveFgColor),
            ),
            const SizedBox(height: 4),
            SizedBox(
              height: 2,
              width: 24,
              child: LinearProgressIndicator(
                color: effectiveFgColor,
                backgroundColor: Colors.transparent,
              ),
            ),
          ],
        );
      }
    } else {
      // Normal State
      if (widget.icon != null) {
        content = Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(widget.icon, color: effectiveFgColor, size: 20),
            const SizedBox(width: AppSpacing.sm),
            Text(
              widget.label,
              style:
                  theme.textTheme.labelLarge?.copyWith(color: effectiveFgColor),
            ),
          ],
        );
      } else {
        content = Text(
          widget.label,
          style: theme.textTheme.labelLarge?.copyWith(color: effectiveFgColor),
        );
      }
    }

    final buttonStyle = ElevatedButton.styleFrom(
      backgroundColor: effectiveBgColor,
      foregroundColor: effectiveFgColor,
      elevation: 0,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xl,
        vertical: AppSpacing.lg,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.md),
      ),
      // We handle disabled state manually to support tap-on-disabled
      disabledBackgroundColor: effectiveBgColor,
      disabledForegroundColor: effectiveFgColor,
    );

    final button = SizedBox(
      width: widget.isFullWidth ? double.infinity : null,
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
}
