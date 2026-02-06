import 'package:flutter/material.dart';
import 'package:pingo/core/presentation/widgets/atoms/atoms.dart';
import 'package:pingo/core/theme/app_theme.dart';
import 'package:pingo/core/theme/radius.dart';
import 'package:pingo/core/theme/spacing.dart';

class PingoMediaCarousel extends StatelessWidget {
  final List<String> imageUrls;
  final double height;
  final Function(int index)? onPageChanged;

  const PingoMediaCarousel({
    super.key,
    required this.imageUrls,
    this.height = 200.0,
    this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    if (imageUrls.isEmpty) {
      return Container(
        height: height,
        color: AppColors.neutral.s200,
        child: Center(
          child: PingoIcon(
            Icons.image_not_supported,
            color: AppColors.neutral.s400,
            size: PingoIconSize.large,
          ),
        ),
      );
    }

    return SizedBox(
      height: height,
      child: PageView.builder(
        itemCount: imageUrls.length,
        onPageChanged: onPageChanged,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
            decoration: BoxDecoration(
              borderRadius: AppRadius.all8,
              image: DecorationImage(
                image: NetworkImage(imageUrls[index]),
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
