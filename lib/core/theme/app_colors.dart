import 'package:flutter/material.dart';

/// Centralized design system colors.
/// Mirrors Figma design system for Voice Command application.
class AppColors {
  AppColors._();

  // Primary palette
  static const Color primary = Color(0xFF1E3A5F);
  static const Color primaryLight = Color(0xFF2D4A6F);
  static const Color primaryDark = Color(0xFF152A45);

  // Accent for voice / CTA
  static const Color accent = Color(0xFF0D9488);
  static const Color accentLight = Color(0xFF14B8A6);
  static const Color accentDark = Color(0xFF0F766E);

  // Surface & background
  static const Color background = Color(0xFFF8FAFC);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceElevated = Color(0xFFFFFFFF);

  // Text
  static const Color textPrimary = Color(0xFF0F172A);
  static const Color textSecondary = Color(0xFF64748B);
  static const Color textOnPrimary = Color(0xFFFFFFFF);
  static const Color textOnAccent = Color(0xFFFFFFFF);

  // Semantic
  static const Color success = Color(0xFF059669);
  static const Color error = Color(0xFFDC2626);
  static const Color warning = Color(0xFFD97706);

  // Balance / money
  static const Color balancePositive = Color(0xFF059669);
  static const Color balanceNegative = Color(0xFFDC2626);
}
