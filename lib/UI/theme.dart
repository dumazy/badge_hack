import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryRed = Color(0xFFF24162);
  static const Color primaryPink = Color(0xFFD93BA1);
  static const Color secondaryPink = Color(0xFFD93BCE);
  static const Color accent = Color(0xFFF26430);
  static const Color background = Color(0xFF0D0D0D);
}

ThemeData appTheme() {
  return ThemeData(
    primaryColor: AppColors.primaryRed,
    scaffoldBackgroundColor: AppColors.background,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primaryRed,
      secondary: AppColors.accent,
      surface: AppColors.background,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.background,
      foregroundColor: AppColors.primaryRed,
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(color: AppColors.primaryRed),
      displayMedium: TextStyle(color: AppColors.primaryPink),
      displaySmall: TextStyle(color: Colors.white),
      headlineLarge: TextStyle(color: Colors.white70),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: AppColors.accent,
      textTheme: ButtonTextTheme.primary,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.accent,
    ),
  );
}
