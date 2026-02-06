import 'package:flutter/material.dart';
import 'package:pingo/core/presentation/widgets/atoms/atoms.dart';
import 'package:pingo/core/theme/spacing.dart';

enum PingoPinListVariant {
  grouped,
  flat,
}

class PingoPinList extends StatelessWidget {
  final PingoPinListVariant variant;
  final List<Widget> items;
  final Widget? emptyState;
  final ScrollPhysics? physics;
  final bool shrinkWrap;

  const PingoPinList({
    super.key,
    this.variant = PingoPinListVariant.flat,
    required this.items,
    this.emptyState,
    this.physics,
    this.shrinkWrap = false,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return emptyState ??
          const Center(
            child: PingoText.body("No pins found."),
          );
    }

    if (variant == PingoPinListVariant.grouped) {
      // Logic for grouped list would go here (requires map of groups)
      // For now, simple list
    }

    return ListView.separated(
      physics: physics,
      shrinkWrap: shrinkWrap,
      itemCount: items.length,
      separatorBuilder: (context, index) => const PingoDivider.horizontal(),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            vertical: AppSpacing.sm,
            horizontal: AppSpacing.md,
          ),
          child: items[index],
        );
      },
    );
  }
}
