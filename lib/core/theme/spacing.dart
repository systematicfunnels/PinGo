import 'package:flutter/material.dart';

// App spacing constants
// Rules: 4, 8, 12, 16, 24, 32
// Rhythm over density
class AppSpacing {
  AppSpacing._(); // Private constructor to prevent instantiation

  // Base values
  static const double xs = 4.0; // Internal padding (icons, chips)
  static const double sm = 8.0; // Internal padding
  static const double md = 12.0; // Content separation
  static const double lg = 16.0; // Content separation
  static const double xl = 24.0; // Section breaks
  static const double xxl = 32.0; // Section breaks
  static const double xxxl = 48.0; // Huge section breaks

  // Numeric aliases (matching Spacing.4, Spacing.8, etc.)
  static const double s4 = xs;
  static const double s8 = sm;
  static const double s12 = md;
  static const double s16 = lg;
  static const double s24 = xl;
  static const double s32 = xxl;
  static const double s48 = xxxl;

  // Semantic aliases
  static const double internal = sm;
  static const double content = lg;
  static const double section = xxl;

  // Helpers for common specific usages
  static const double iconSpacing = xs;
  static const double chipSpacing = xs;
  static const double cardPadding = lg; // Updated to 16px (Spacing.16)
  static const double screenPadding = lg; // Spacing.16
  static const double sectionSpacing = xxl;

  // EdgeInsets helpers
  static const EdgeInsets allXs = EdgeInsets.all(xs);
  static const EdgeInsets allSm = EdgeInsets.all(sm);
  static const EdgeInsets allMd = EdgeInsets.all(md);
  static const EdgeInsets allLg = EdgeInsets.all(lg);
  static const EdgeInsets allXl = EdgeInsets.all(xl);
  static const EdgeInsets allXxl = EdgeInsets.all(xxl);
  static const EdgeInsets allXxxl = EdgeInsets.all(xxxl);

  static const EdgeInsets hSm = EdgeInsets.symmetric(horizontal: sm);
  static const EdgeInsets hMd = EdgeInsets.symmetric(horizontal: md);
  static const EdgeInsets hLg = EdgeInsets.symmetric(horizontal: lg);

  static const EdgeInsets vSm = EdgeInsets.symmetric(vertical: sm);
  static const EdgeInsets vMd = EdgeInsets.symmetric(vertical: md);
  static const EdgeInsets vLg = EdgeInsets.symmetric(vertical: lg);
}
