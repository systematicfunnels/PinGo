import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pingo/core/theme/spacing.dart';

// --- Color Tokens ---

class AppColors {
  static const primary = _PrimaryColors();
  static const neutral = _NeutralColors();
  static const success = _SuccessColors();
  static const warning = _WarningColors();
  static const error = _ErrorColors();
  static const info = _InfoColors();
  static const map = _MapColors();
}

class _PrimaryColors {
  const _PrimaryColors();
  final Color s500 = const Color(0xFF2C4A52); // Main brand accent (Deep Forest)
  final Color s400 = const Color(0xFF40626C);
  final Color s300 = const Color(0xFF65838C);
  final Color s100 = const Color(0xFFE0E8E9); // Subtle background
}

class _NeutralColors {
  const _NeutralColors();
  final Color s900 = const Color(0xFF2D2D2D); // Primary text
  final Color s700 = const Color(0xFF5C5C5C); // Secondary text
  final Color s500 = const Color(0xFF8E8E8E); // Tertiary / hints
  final Color s300 = const Color(0xFFE0E0E0); // Dividers
  final Color s100 = const Color(0xFFFFFFFF); // Surface
  final Color s50 = const Color(0xFFF5F5F0); // Background (Soft Sand)
}

class _SuccessColors {
  const _SuccessColors();
  final Color s500 = const Color(0xFF7E9C82); // Muted sage green
}

class _WarningColors {
  const _WarningColors();
  final Color s500 = const Color(0xFFD4A373); // Caution, risk (Amber)
}

class _ErrorColors {
  const _ErrorColors();
  final Color s500 = const Color(0xFFC27E7E); // Failure, blocked (Muted Rust)
}

class _InfoColors {
  const _InfoColors();
  final Color s500 = const Color(0xFF6B8E9B); // Neutral info (Slate Blue)
}

class _MapColors {
  const _MapColors();
  final Color route = const Color(0xFF40626C); // Softer than pin (Primary 400)
  final Color pin = const Color(0xFF2C4A52); // Primary 500
  final Color pinSelected =
      const Color(0xFF1A1A1A); // Clearer, not brighter (Neutral 900 variant)
  final Color water = const Color(0xFFB8D0D5); // Soft Blue
  final Color danger = const Color(0xFFC27E7E); // Error 500
}

// --- Typography ---

class AppTypography {
  static TextTheme get textTheme {
    return TextTheme(
      displayLarge: GoogleFonts.libreBaskerville(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: AppColors.neutral.s900,
      ),
      displayMedium: GoogleFonts.libreBaskerville(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: AppColors.neutral.s900,
      ),
      titleLarge: GoogleFonts.libreBaskerville(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.neutral.s900,
      ),
      bodyLarge: GoogleFonts.inter(
        fontSize: 16,
        height: 1.5,
        color: AppColors.neutral.s900,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 14,
        height: 1.5,
        color: AppColors.neutral.s700,
      ),
      labelLarge: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
        color: AppColors.neutral.s900,
      ),
    );
  }
}

// --- Theme Data ---

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: AppColors.primary.s500,
        onPrimary: AppColors.neutral.s100,
        secondary: AppColors.primary.s300, // Used for highlights/progress
        onSecondary: AppColors.neutral.s100,
        error: AppColors.error.s500,
        onError: AppColors.neutral.s100,
        surface: AppColors.neutral.s100,
        onSurface: AppColors.neutral.s900,
      ),
      scaffoldBackgroundColor: AppColors.neutral.s50,
      textTheme: AppTypography.textTheme,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary.s500,
          foregroundColor: AppColors.neutral.s100,
          elevation: 0,
          padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.xl, vertical: AppSpacing.lg),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.md),
          ),
          textStyle: AppTypography.textTheme.labelLarge,
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.neutral.s100,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: AppColors.neutral.s300, width: 0.5),
        ),
        margin: EdgeInsets.zero,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.neutral
            .s50, // Surface variant logic? Old was surfaceVariant. s50 is background.
        // Old surfaceVariant was EBEBE6. s50 is F5F5F0. Close enough.
        // Actually, let's stick to s50 for inputs on s100 cards.
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.md,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.md),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.md),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.md),
          borderSide: BorderSide(color: AppColors.primary.s500, width: 1.5),
        ),
        labelStyle: AppTypography.textTheme.bodyMedium,
        hintStyle: AppTypography.textTheme.bodyMedium?.copyWith(
          color: AppColors.neutral.s500,
        ),
      ),
    );
  }
}
