import 'package:flutter/material.dart';
import 'package:pingo/core/presentation/widgets/atoms/atoms.dart';
import 'package:pingo/core/theme/app_theme.dart';

enum PingoPinMarkerType {
  place,
  food,
  safety,
  story,
}

class PingoPinMarker extends StatelessWidget {
  final PingoPinMarkerType type;
  final bool isSelected;
  final bool isDraft;
  final bool isSensitive;
  final bool isSynced;
  final VoidCallback? onTap;

  const PingoPinMarker({
    super.key,
    this.type = PingoPinMarkerType.place,
    this.isSelected = false,
    this.isDraft = false,
    this.isSensitive = false,
    this.isSynced = true,
    this.onTap,
  });

  IconData _getIcon() {
    if (isSensitive) return Icons.visibility_off;
    switch (type) {
      case PingoPinMarkerType.place:
        return Icons.place;
      case PingoPinMarkerType.food:
        return Icons.restaurant;
      case PingoPinMarkerType.safety:
        return Icons.health_and_safety;
      case PingoPinMarkerType.story:
        return Icons.auto_stories;
    }
  }

  Color _getColor() {
    if (isDraft) return AppColors.neutral.s500;
    if (isSensitive) return AppColors.neutral.s600;

    switch (type) {
      case PingoPinMarkerType.place:
        return AppColors.primary.s500;
      case PingoPinMarkerType.food:
        return AppColors.info.s500; // Using Info for Food
      case PingoPinMarkerType.safety:
        return AppColors.error.s500;
      case PingoPinMarkerType.story:
        return AppColors.map.pin; // Using Map pin color for Story
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _getColor();
    final size = isSelected ? 48.0 : 40.0;
    final iconSize = isSelected ? PingoIconSize.medium : PingoIconSize.small;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: isSelected
              ? Border.all(color: AppColors.neutral.s100, width: 3)
              : Border.all(color: Colors.white, width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            Center(
              child: PingoIcon(
                _getIcon(),
                color: AppColors.neutral.s100,
                size: iconSize,
              ),
            ),
            if (!isSynced && !isDraft)
              Positioned(
                right: -4,
                bottom: -4,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.cloud_off,
                    size: 12,
                    color: AppColors.neutral.s700,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
