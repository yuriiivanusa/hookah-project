import 'package:flutter/material.dart';

sealed class AppColors {
  // Primary — amber/gold (fire, tobacco)
  static const Color primary = Color(0xFFD4870A);
  static const Color primaryLight = Color(0xFFFFB740);
  static const Color primaryDark = Color(0xFF9A5C00);

  // Secondary — warm brown (tobacco leaf)
  static const Color secondary = Color(0xFF8D6344);
  static const Color secondaryLight = Color(0xFFBF8F6E);
  static const Color secondaryDark = Color(0xFF5E3B1E);

  // Surfaces — dark (hookah lounge ambiance)
  static const Color surface = Color(0xFF1A1612);
  static const Color surfaceVariant = Color(0xFF2C2420);
  static const Color surfaceContainer = Color(0xFF231E1A);
  static const Color surfaceContainerHigh = Color(0xFF332C27);

  // Backgrounds
  static const Color backgroundDark = Color(0xFF120F0C);
  static const Color backgroundLight = Color(0xFFFDF8F2);

  // On-colors (text/icons on top of surfaces)
  static const Color onPrimary = Color(0xFF1A1612);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color onSurfaceDark = Color(0xFFEDE0D4);
  static const Color onSurfaceLight = Color(0xFF1A1612);

  // Error
  static const Color error = Color(0xFFCF6679);
  static const Color onError = Color(0xFF1A1612);

  // Neutral accents
  static const Color outline = Color(0xFF7A6A5F);
  static const Color outlineVariant = Color(0xFF4A3D35);

  // Semantic
  static const Color success = Color(0xFF5E9E6B);
  static const Color warning = Color(0xFFD4A017);

  // Light scheme
  static ColorScheme get lightScheme => ColorScheme(
    brightness: Brightness.light,
    primary: primary,
    onPrimary: onPrimary,
    secondary: secondary,
    onSecondary: onSecondary,
    surface: backgroundLight,
    onSurface: onSurfaceLight,
    error: error,
    onError: onError,
    surfaceContainerHighest: const Color(0xFFEDE0D4),
    outline: outline,
  );

  // Dark scheme
  static ColorScheme get darkScheme => ColorScheme(
    brightness: Brightness.dark,
    primary: primary,
    onPrimary: onPrimary,
    secondary: secondary,
    onSecondary: onSecondary,
    surface: surface,
    onSurface: onSurfaceDark,
    error: error,
    onError: onError,
    surfaceContainerHighest: surfaceContainerHigh,
    outline: outline,
  );
}
