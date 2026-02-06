import 'package:flutter/material.dart';

class AppRadius {
  // Radius Tokens
  static const double r4 = 4.0;   // Chips, tags
  static const double r8 = 8.0;   // Buttons
  static const double r12 = 12.0; // Cards
  static const double r16 = 16.0; // Modals, sheets
  static const double full = 999.0; // Pills, avatars

  // BorderRadius Helpers
  static const BorderRadius all4 = BorderRadius.all(Radius.circular(r4));
  static const BorderRadius all8 = BorderRadius.all(Radius.circular(r8));
  static const BorderRadius all12 = BorderRadius.all(Radius.circular(r12));
  static const BorderRadius all16 = BorderRadius.all(Radius.circular(r16));
  static const BorderRadius allFull = BorderRadius.all(Radius.circular(full));

  // Top/Bottom Helpers (for Sheets/Modals)
  static const BorderRadius top16 = BorderRadius.vertical(top: Radius.circular(r16));
  static const BorderRadius bottom16 = BorderRadius.vertical(bottom: Radius.circular(r16));
}
