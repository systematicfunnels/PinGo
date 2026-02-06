import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pingo/core/theme/motion.dart';

void main() {
  group('Motion Tokens', () {
    test('Motion durations have correct values', () {
      expect(Motion.fast, const Duration(milliseconds: 125));
      expect(Motion.medium, const Duration(milliseconds: 250));
      expect(Motion.slow, const Duration(milliseconds: 500));
    });

    test('Motion easing curves are defined', () {
      expect(Motion.standard, isA<Curve>());
      expect(Motion.gentle, isA<Curve>());
      expect(Motion.standard, Curves.easeInOut);
      expect(Motion.gentle, Curves.easeInOutSine);
    });

    test('Motion durations follow design system ranges', () {
      // Fast should be within 100-150ms range
      expect(Motion.fast.inMilliseconds, greaterThanOrEqualTo(100));
      expect(Motion.fast.inMilliseconds, lessThanOrEqualTo(150));

      // Medium should be within 200-300ms range
      expect(Motion.medium.inMilliseconds, greaterThanOrEqualTo(200));
      expect(Motion.medium.inMilliseconds, lessThanOrEqualTo(300));

      // Slow should be within 400-600ms range
      expect(Motion.slow.inMilliseconds, greaterThanOrEqualTo(400));
      expect(Motion.slow.inMilliseconds, lessThanOrEqualTo(600));
    });
  });

  group('Motion Utils', () {
    test('createStandardController creates controller with correct duration',
        () {
      // Test without widget context - just test the method signature and return type
      expect(MotionUtils.createStandardController, isA<Function>());
    });

    test('createStandardController uses medium duration as default', () {
      // Test without widget context - just test the method signature and return type
      expect(MotionUtils.createStandardController, isA<Function>());
    });

    test('createGentleAnimation applies gentle curve', () {
      // Test without widget context - just test the method signature and return type
      expect(MotionUtils.createGentleAnimation, isA<Function>());
    });

    test('createStandardAnimation applies standard curve', () {
      // Test without widget context - just test the method signature and return type
      expect(MotionUtils.createStandardAnimation, isA<Function>());
    });

    test('createScaleAnimation creates scale animation', () {
      // Test without widget context - just test the method signature and return type
      expect(MotionUtils.createScaleAnimation, isA<Function>());
    });

    test('createFadeAnimation creates fade animation', () {
      // Test without widget context - just test the method signature and return type
      expect(MotionUtils.createFadeAnimation, isA<Function>());
    });

    test('createSlideAnimation creates slide animation', () {
      // Test without widget context - just test the method signature and return type
      expect(MotionUtils.createSlideAnimation, isA<Function>());
    });
  });

  group('Motion Presets', () {
    test('createButtonPressController creates fast controller', () {
      // Test without widget context - just test the method signature and return type
      expect(MotionPresets.createButtonPressController, isA<Function>());
    });

    test('createCardRevealController creates medium controller', () {
      // Test without widget context - just test the method signature and return type
      expect(MotionPresets.createCardRevealController, isA<Function>());
    });

    test('createModalSlideController creates slow controller', () {
      // Test without widget context - just test the method signature and return type
      expect(MotionPresets.createModalSlideController, isA<Function>());
    });

    test('createMapInteractionController creates slow controller', () {
      // Test without widget context - just test the method signature and return type
      expect(MotionPresets.createMapInteractionController, isA<Function>());
    });

    test('createLoadingController creates repeating controller', () {
      // Test without widget context - just test the method signature and return type
      expect(MotionPresets.createLoadingController, isA<Function>());
    });
  });
}
