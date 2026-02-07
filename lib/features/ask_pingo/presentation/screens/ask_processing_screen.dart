import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pingo/core/routing/route_paths.dart';
import 'package:pingo/core/theme/app_theme.dart';

class AskProcessingScreen extends StatefulWidget {
  const AskProcessingScreen({super.key});

  @override
  State<AskProcessingScreen> createState() => _AskProcessingScreenState();
}

class _AskProcessingScreenState extends State<AskProcessingScreen> with SingleTickerProviderStateMixin {
  int _currentState = 0;
  final List<String> _states = [
    'Analyzing context...',
    'Connecting insights...',
    'Formulating response...',
  ];
  
  Timer? _stateTimer;
  Timer? _navigationTimer;
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    
    // Cycle through processing states
    _stateTimer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (mounted) {
        setState(() {
          _currentState = (_currentState + 1) % _states.length;
        });
      }
    });

    // Navigate to response after 6 seconds
    _navigationTimer = Timer(const Duration(seconds: 6), () {
      if (mounted) {
        context.pushReplacement(RoutePaths.askResponse);
      }
    });
    
    // Pulse animation
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.5).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _stateTimer?.cancel();
    _navigationTimer?.cancel();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animated pulse circles
            SizedBox(
              width: 100,
              height: 100,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  AnimatedBuilder(
                    animation: _pulseAnimation,
                    builder: (context, child) {
                      return Container(
                        width: 60 * _pulseAnimation.value,
                        height: 60 * _pulseAnimation.value,
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                      );
                    },
                  ),
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.4),
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 32),
            
            // Processing text
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: Text(
                _states[_currentState],
                key: ValueKey<int>(_currentState),
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontFamily: 'Serif',
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            
            const SizedBox(height: 8),
            
            Text(
              'This will just take a moment',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            
            const SizedBox(height: 32),
            
            // Progress dots
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_states.length, (index) {
                final isActive = index == _currentState;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: isActive ? 24 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: isActive ? AppColors.primary : AppColors.border,
                    borderRadius: BorderRadius.circular(4),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
