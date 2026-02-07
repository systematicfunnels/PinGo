import 'package:flutter/material.dart';
import 'package:pingo/core/theme/app_theme.dart';

enum PingoAvatarSize {
  small, // 32px
  medium, // 40px
  large, // 56px
}

class PingoAvatar extends StatelessWidget {
  final String? imageUrl;
  final PingoAvatarSize size;
  final bool isLoading;
  final bool isEmpty;
  final String? initials;

  const PingoAvatar({
    super.key,
    this.imageUrl,
    this.size = PingoAvatarSize.medium,
    this.isLoading = false,
    this.isEmpty = false,
    this.initials,
  });

  @override
  Widget build(BuildContext context) {
    final double avatarSize = _getSize(size);
    final Color backgroundColor = AppColors.neutral.s300;
    final Color foregroundColor = AppColors.neutral.s700;

    if (isLoading) {
      return SizedBox(
        width: avatarSize,
        height: avatarSize,
        child: CircleAvatar(
          backgroundColor: backgroundColor,
          child: const Padding(
            padding: EdgeInsets.all(4.0),
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
        ),
      );
    }

    if (isEmpty || (imageUrl == null && initials == null)) {
      return CircleAvatar(
        radius: avatarSize / 2,
        backgroundColor: backgroundColor,
        child: Icon(
          Icons.person,
          size: avatarSize * 0.6,
          color: foregroundColor,
        ),
      );
    }

    if (imageUrl != null) {
      return CircleAvatar(
        radius: avatarSize / 2,
        backgroundColor: backgroundColor,
        backgroundImage: NetworkImage(imageUrl!),
        onBackgroundImageError: (_, __) {
          // Fallback handled by child if needed, but CircleAvatar doesn't easily support fallback widget on error
          // In production, use CachedNetworkImage
        },
      );
    }

    return CircleAvatar(
      radius: avatarSize / 2,
      backgroundColor: AppColors.primary.s100,
      child: Text(
        initials ?? '',
        style: TextStyle(
          color: AppColors.primary.s500,
          fontWeight: FontWeight.bold,
          fontSize: avatarSize * 0.4,
        ),
      ),
    );
  }

  double _getSize(PingoAvatarSize size) {
    switch (size) {
      case PingoAvatarSize.small:
        return 32.0;
      case PingoAvatarSize.medium:
        return 40.0;
      case PingoAvatarSize.large:
        return 56.0;
    }
  }
}
