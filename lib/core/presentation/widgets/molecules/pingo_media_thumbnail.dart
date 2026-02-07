import 'package:flutter/material.dart';
import 'package:pingo/core/theme/app_theme.dart';
import 'package:pingo/core/theme/radius.dart';
import 'package:pingo/core/presentation/widgets/atoms/atoms.dart';

enum PingoMediaType {
  image,
  video,
}

class PingoMediaThumbnail extends StatelessWidget {
  final String? imageUrl;
  final PingoMediaType type;
  final bool isLoading;
  final bool isError;
  final double width;
  final double height;
  final VoidCallback? onTap;

  const PingoMediaThumbnail({
    super.key,
    this.imageUrl,
    this.type = PingoMediaType.image,
    this.isLoading = false,
    this.isError = false,
    this.width = 80.0,
    this.height = 80.0,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Widget content;

    if (isLoading) {
      content = Center(
        child: PingoProgressIndicator.circular(
          color: AppColors.neutral.s500,
        ),
      );
    } else if (isError || imageUrl == null) {
      content = Center(
        child: PingoIcon(
          Icons.broken_image_outlined,
          color: AppColors.neutral.s500,
          size: PingoIconSize.medium,
        ),
      );
    } else {
      content = Image.network(
        imageUrl!,
        fit: BoxFit.cover,
        width: width,
        height: height,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: PingoProgressIndicator.circular(
              color: AppColors.neutral.s500,
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return Center(
            child: PingoIcon(
              Icons.broken_image_outlined,
              color: AppColors.neutral.s500,
              size: PingoIconSize.medium,
            ),
          );
        },
      );
    }

    return InkWell(
      onTap: onTap,
      borderRadius: AppRadius.all8,
      child: Container(
        width: width,
        height: height,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: AppColors.neutral.s100,
          borderRadius: AppRadius.all8,
          border: Border.all(color: AppColors.neutral.s300),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            content,
            if (type == PingoMediaType.video && !isLoading && !isError)
              Center(
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    shape: BoxShape.circle,
                  ),
                  child: const PingoIcon(
                    Icons.play_arrow,
                    color: Colors.white,
                    size: PingoIconSize.medium,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
