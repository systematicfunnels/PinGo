import 'package:flutter/material.dart';
import 'package:pingo/core/theme/spacing.dart';

enum PingoActionBarVariant {
  map,
  record,
}

class PingoActionBar extends StatelessWidget {
  final PingoActionBarVariant variant;
  final List<Widget> leadingActions;
  final Widget? primaryAction;
  final List<Widget> trailingActions;
  final bool isHidden;

  const PingoActionBar({
    super.key,
    this.variant = PingoActionBarVariant.map,
    this.leadingActions = const [],
    this.primaryAction,
    this.trailingActions = const [],
    this.isHidden = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isHidden) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Leading Actions (e.g., Layers, Settings)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (var action in leadingActions) ...[
                action,
                const SizedBox(width: AppSpacing.md),
              ],
            ],
          ),

          // Primary Action (Center/Right-Center - usually FAB)
          if (primaryAction != null) primaryAction!,

          // Trailing Actions (e.g., Locate Me)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (var action in trailingActions) ...[
                const SizedBox(width: AppSpacing.md),
                action,
              ],
            ],
          ),
        ],
      ),
    );
  }
}
