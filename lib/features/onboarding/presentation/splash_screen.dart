import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pingo/core/presentation/widgets/pingo_button.dart';
import 'package:pingo/core/theme/app_theme.dart';
import 'package:pingo/core/theme/spacing.dart';
import 'package:pingo/core/routing/route_paths.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          backgroundColor: AppColors.neutral.s50,
          body: Stack(
            children: [
              Positioned.fill(
                child: Opacity(
                  opacity: 0.05,
                  child: CustomPaint(
                    painter: TopographicPainter(),
                  ),
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(),
                      Icon(
                        Icons.explore_off_outlined,
                        size: 80,
                        color: AppColors.primary.s500,
                      ),
                      const SizedBox(height: AppSpacing.xxl),
                      Text(
                        'The world is bigger than the map.',
                        style: Theme.of(context).textTheme.displayLarge?.copyWith(
                              height: 1.2,
                            ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      Text(
                        'Create your own journeys. Save moments. Share only when ready.',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: AppColors.neutral.s700,
                            ),
                        textAlign: TextAlign.center,
                      ),
                      const Spacer(),
                      PingoButton(
                        onPressed: () {
                          context.go(RoutePaths.welcome);
                        },
                        label: 'Start exploring',
                      ),
                      const SizedBox(height: AppSpacing.xxl),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
  }
}

// Simple painter for background texture
class TopographicPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.neutral.s900
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    // Draw some random curved lines to simulate topography
    final path = Path();
    path.moveTo(0, size.height * 0.2);
    path.quadraticBezierTo(
      size.width * 0.5,
      size.height * 0.3,
      size.width,
      size.height * 0.1,
    );

    path.moveTo(0, size.height * 0.5);
    path.quadraticBezierTo(
      size.width * 0.3,
      size.height * 0.6,
      size.width,
      size.height * 0.4,
    );

    path.moveTo(0, size.height * 0.8);
    path.quadraticBezierTo(
      size.width * 0.7,
      size.height * 0.7,
      size.width,
      size.height * 0.9,
    );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
