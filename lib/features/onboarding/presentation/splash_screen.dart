import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pingo/core/theme/app_theme.dart';
import 'package:pingo/core/routing/route_paths.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late final AnimationController _rotateController;
  late final AnimationController _fadeController;

  late final Animation<double> _headlineOpacity;
  late final Animation<Offset> _headlineSlide;
  late final Animation<double> _subtextOpacity;
  late final Animation<Offset> _subtextSlide;
  late final Animation<double> _btnOpacity;
  late final Animation<Offset> _btnSlide;
  late final Animation<double> _brandOpacity;

  @override
  void initState() {
    super.initState();

    // Continuous rotation for compass (20s duration matches React)
    _rotateController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();

    // Staggered entrance animations
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _headlineOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: _fadeController,
          curve: const Interval(0.2, 0.6, curve: Curves.easeOut)),
    );
    _headlineSlide =
        Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero).animate(
      CurvedAnimation(
          parent: _fadeController,
          curve: const Interval(0.2, 0.6, curve: Curves.easeOut)),
    );

    _subtextOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: _fadeController,
          curve: const Interval(0.4, 0.8, curve: Curves.easeOut)),
    );
    _subtextSlide =
        Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero).animate(
      CurvedAnimation(
          parent: _fadeController,
          curve: const Interval(0.4, 0.8, curve: Curves.easeOut)),
    );

    _btnOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: _fadeController,
          curve: const Interval(0.6, 1.0, curve: Curves.easeOut)),
    );
    _btnSlide =
        Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero).animate(
      CurvedAnimation(
          parent: _fadeController,
          curve: const Interval(0.6, 1.0, curve: Curves.easeOut)),
    );

    _brandOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: _fadeController,
          curve: const Interval(0.8, 1.0, curve: Curves.easeOut)),
    );

    _fadeController.forward();
  }

  @override
  void dispose() {
    _rotateController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Background texture (placeholder)
          Positioned.fill(
            child: Opacity(
              opacity: 0.05,
              child: CustomPaint(
                painter: _DotPatternPainter(),
              ),
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),

                  // Abstract Compass/Path Motif
                  AnimatedBuilder(
                    animation: _rotateController,
                    builder: (context, child) {
                      return Transform.rotate(
                        angle: _rotateController.value * 2 * math.pi,
                        child: child,
                      );
                    },
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: AppColors.primary.withValues(alpha: 0.2),
                            width: 2),
                      ),
                      child: const Icon(
                        Icons.explore_outlined,
                        size: 60,
                        color: AppColors.primary,
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Headline
                  SlideTransition(
                    position: _headlineSlide,
                    child: FadeTransition(
                      opacity: _headlineOpacity,
                      child: Text(
                        'The world is bigger than the map.',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                              fontFamily: 'Serif',
                              fontWeight: FontWeight.bold,
                              height: 1.2,
                              color: AppColors.textPrimary,
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Subtext
                  SlideTransition(
                    position: _subtextSlide,
                    child: FadeTransition(
                      opacity: _subtextOpacity,
                      child: Text(
                        'Create your own journeys. Save moments. Share only when ready.',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: AppColors.textSecondary,
                              height: 1.5,
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),

                  const SizedBox(height: 48),

                  // Primary CTA
                  SlideTransition(
                    position: _btnSlide,
                    child: FadeTransition(
                      opacity: _btnOpacity,
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            context.go(RoutePaths.welcome);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: AppColors.onPrimary,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            elevation: 4,
                          ),
                          child: const Text(
                            'Start exploring',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  
                  const Spacer(),
                  
                  // Brand
                  FadeTransition(
                    opacity: _brandOpacity,
                    child: Column(
                      children: [
                        Text(
                          'Pingo',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontFamily: 'Serif',
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Pin it. Plan it. Go.',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textTertiary,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DotPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.textPrimary
      ..strokeWidth = 1.0;

    // Draw a simple grid of dots
    const double spacing = 40.0;
    for (double x = 0; x < size.width; x += spacing) {
      for (double y = 0; y < size.height; y += spacing) {
        if ((x + y) % (spacing * 2) == 0) { // Sparse pattern
            canvas.drawCircle(Offset(x, y), 1, paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
