import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_tokens.dart';
import 'app_typography.dart';

sealed class AppTheme {
  static ThemeData get dark => _build(AppColors.darkScheme);
  static ThemeData get light => _build(AppColors.lightScheme);

  static ThemeData _build(ColorScheme scheme) => ThemeData(
        useMaterial3: true,
        colorScheme: scheme,
        textTheme: AppTypography.textTheme.apply(
          bodyColor: scheme.onSurface,
          displayColor: scheme.onSurface,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: scheme.surface,
          foregroundColor: scheme.onSurface,
          elevation: AppTokens.elevationNone,
          centerTitle: false,
        ),
        cardTheme: CardThemeData(
          color: scheme.surfaceContainerHighest,
          elevation: AppTokens.elevationSm,
          shape: const RoundedRectangleBorder(
            borderRadius: AppTokens.borderRadiusMd,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: scheme.primary,
            foregroundColor: scheme.onPrimary,
            shape: const RoundedRectangleBorder(
              borderRadius: AppTokens.borderRadiusMd,
            ),
            minimumSize: const Size.fromHeight(52),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: scheme.primary,
            side: BorderSide(color: scheme.primary),
            shape: const RoundedRectangleBorder(
              borderRadius: AppTokens.borderRadiusMd,
            ),
            minimumSize: const Size.fromHeight(52),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: scheme.surfaceContainerHighest,
          border: const OutlineInputBorder(
            borderRadius: AppTokens.borderRadiusMd,
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: AppTokens.borderRadiusMd,
            borderSide: BorderSide(color: scheme.primary, width: 2),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: scheme.surface,
          selectedItemColor: scheme.primary,
          unselectedItemColor: scheme.onSurface.withValues(alpha: 0.5),
          type: BottomNavigationBarType.fixed,
          elevation: AppTokens.elevationMd,
        ),
        dividerTheme: DividerThemeData(
          color: scheme.outline.withValues(alpha: 0.3),
          thickness: 1,
        ),
        scaffoldBackgroundColor: scheme.surface,
      );
}
