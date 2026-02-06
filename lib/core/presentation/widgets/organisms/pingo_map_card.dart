import 'package:flutter/material.dart';
import 'package:pingo/core/presentation/widgets/atoms/atoms.dart';
import 'package:pingo/core/presentation/widgets/molecules/molecules.dart';
import 'package:pingo/core/theme/app_theme.dart';
import 'package:pingo/core/theme/radius.dart';
import 'package:pingo/core/theme/spacing.dart';

enum PingoMapCardIntent {
  feed,
  library,
}

class PingoMapCard extends StatelessWidget {
  final PingoMapCardIntent intent;
  final String title;
  final String? subtitle;
  final String? imageUrl;
  final double? distance;
  final bool isSaved;
  final bool isFollowing;
  final VoidCallback? onTap;
  final VoidCallback? onSave;
  final VoidCallback? onFollow;

  const PingoMapCard({
    super.key,
    this.intent = PingoMapCardIntent.feed,
    required this.title,
    this.subtitle,
    this.imageUrl,
    this.distance,
    this.isSaved = false,
    this.isFollowing = false,
    this.onTap,
    this.onSave,
    this.onFollow,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: intent == PingoMapCardIntent.feed ? double.infinity : 200,
        decoration: BoxDecoration(
          color: AppColors.neutral.s100,
          borderRadius: AppRadius.all12,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image / Placeholder
            Container(
              height: intent == PingoMapCardIntent.feed ? 180 : 120,
              width: double.infinity,
              color: AppColors.neutral.s200,
              child: imageUrl != null
                  ? Image.network(imageUrl!, fit: BoxFit.cover)
                  : Center(
                      child: PingoIcon(
                        Icons.map,
                        color: AppColors.neutral.s400,
                        size: PingoIconSize.large,
                      ),
                    ),
            ),

            // Content
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PingoText.heading(
                          title,
                          size: intent == PingoMapCardIntent.feed
                              ? PingoTextSize.medium
                              : PingoTextSize.small,
                        ),
                        if (subtitle != null || distance != null) ...[
                          const SizedBox(height: AppSpacing.xs),
                          Row(
                            children: [
                              if (distance != null) ...[
                                PingoIcon(
                                  Icons.near_me,
                                  size: PingoIconSize.small,
                                  color: AppColors.primary.s500,
                                ),
                                const SizedBox(width: 4),
                                PingoText.body(
                                  "${distance!.toStringAsFixed(1)} km",
                                  color: AppColors.primary.s500,
                                  size: PingoTextSize.small,
                                ),
                                if (subtitle != null) ...[
                                  const SizedBox(width: 8),
                                  Container(
                                    width: 4,
                                    height: 4,
                                    decoration: BoxDecoration(
                                      color: AppColors.neutral.s300,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                ],
                              ],
                              if (subtitle != null)
                                Expanded(
                                  child: PingoText.body(
                                    subtitle!,
                                    color: AppColors.neutral.s500,
                                    size: PingoTextSize.small,
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                  if (intent == PingoMapCardIntent.feed && onFollow != null)
                    PingoButton(
                      label: isFollowing ? 'Following' : 'Follow',
                      intent: isFollowing
                          ? PingoButtonIntent.ghost
                          : PingoButtonIntent.secondary,
                      size: PingoButtonSize.sm,
                      onPressed: onFollow,
                    ),
                  if (onSave != null)
                    IconButton(
                      icon: Icon(
                        isSaved ? Icons.bookmark : Icons.bookmark_border,
                        color: isSaved
                            ? AppColors.primary.s500
                            : AppColors.neutral.s400,
                      ),
                      onPressed: onSave,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
