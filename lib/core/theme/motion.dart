import 'package:flutter/material.dart';

/// Motion & Feedback Tokens
///
/// Defines standardized motion durations and easing curves for consistent
/// animations across the PinGo application.
///
/// Based on the design system specification:
/// - Movement explains hierarchy
/// - Never decorative motion
/// - Map motion slower than UI motion
class Motion {
  /// Motion Duration Tokens
  ///
  /// Standardized timing for different types of animations
  static const Duration fast = Duration(milliseconds: 125); // 100–150ms
  static const Duration medium = Duration(milliseconds: 250); // 200–300ms
  static const Duration slow = Duration(milliseconds: 500); // 400–600ms

  /// Motion Easing Curves
  ///
  /// Standardized easing curves for different types of motion
  static const Curve standard = Curves.easeInOut;
  static const Curve gentle = Curves.easeInOutSine;
}

/// Motion Utilities
///
/// Helper utilities for applying motion tokens consistently
class MotionUtils {
  /// Create a standard duration animation controller
  static AnimationController createStandardController({
    required TickerProvider vsync,
    Duration? duration,
  }) {
    return AnimationController(
      duration: duration ?? Motion.medium,
      vsync: vsync,
    );
  }

  /// Create a gentle easing animation
  static Animation<double> createGentleAnimation({
    required AnimationController controller,
    double begin = 0.0,
    double end = 1.0,
  }) {
    return Tween<double>(begin: begin, end: end).animate(
      CurvedAnimation(
        parent: controller,
        curve: Motion.gentle,
      ),
    );
  }

  /// Create a standard easing animation
  static Animation<double> createStandardAnimation({
    required AnimationController controller,
    double begin = 0.0,
    double end = 1.0,
  }) {
    return Tween<double>(begin: begin, end: end).animate(
      CurvedAnimation(
        parent: controller,
        curve: Motion.standard,
      ),
    );
  }

  /// Create a scale animation with gentle easing
  static Animation<double> createScaleAnimation({
    required AnimationController controller,
    double begin = 0.9,
    double end = 1.0,
  }) {
    return Tween<double>(begin: begin, end: end).animate(
      CurvedAnimation(
        parent: controller,
        curve: Motion.gentle,
      ),
    );
  }

  /// Create a fade animation with standard easing
  static Animation<double> createFadeAnimation({
    required AnimationController controller,
    double begin = 0.0,
    double end = 1.0,
  }) {
    return Tween<double>(begin: begin, end: end).animate(
      CurvedAnimation(
        parent: controller,
        curve: Motion.standard,
      ),
    );
  }

  /// Create a slide animation with standard easing
  static Animation<Offset> createSlideAnimation({
    required AnimationController controller,
    Offset begin = Offset.zero,
    Offset end = Offset.zero,
  }) {
    return Tween<Offset>(begin: begin, end: end).animate(
      CurvedAnimation(
        parent: controller,
        curve: Motion.standard,
      ),
    );
  }
}

/// Motion Presets
///
/// Pre-configured motion animations for common use cases
class MotionPresets {
  /// Button press feedback animation
  static AnimationController createButtonPressController({
    required TickerProvider vsync,
  }) {
    return MotionUtils.createStandardController(
      vsync: vsync,
      duration: Motion.fast,
    );
  }

  /// Card reveal animation
  static AnimationController createCardRevealController({
    required TickerProvider vsync,
  }) {
    return MotionUtils.createStandardController(
      vsync: vsync,
      duration: Motion.medium,
    );
  }

  /// Modal slide up animation
  static AnimationController createModalSlideController({
    required TickerProvider vsync,
  }) {
    return MotionUtils.createStandardController(
      vsync: vsync,
      duration: Motion.slow,
    );
  }

  /// Map interaction animation (slower than UI)
  static AnimationController createMapInteractionController({
    required TickerProvider vsync,
  }) {
    return MotionUtils.createStandardController(
      vsync: vsync,
      duration: Motion.slow,
    );
  }

  /// Loading spinner animation
  static AnimationController createLoadingController({
    required TickerProvider vsync,
  }) {
    return AnimationController(
      duration: const Duration(seconds: 1),
      vsync: vsync,
    )..repeat();
  }
}
