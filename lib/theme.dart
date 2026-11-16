import 'package:flutter/material.dart';

/// لوحة الألوان (Teal & Amber) المستمدة من دليل الاتساق البصري.
class AppColors {
  AppColors._();

  static const Color night = Color(0xFF0B1620);
  static const Color nightSoft = Color(0xFF112232);
  static const Color card = Color(0xFF162B3C);
  static const Color cardHigh = Color(0xFF1C364A);
  static const Color teal = Color(0xFF2F7F8F);
  static const Color cobalt = Color(0xFF24476B);
  static const Color amber = Color(0xFFE0A458);
  static const Color amberSoft = Color(0xFFF2C98A);
  static const Color text = Color(0xFFE9EEF2);
  static const Color textDim = Color(0xFF9FB1BE);
  static const Color border = Color(0xFF26455C);
}

ThemeData buildAppTheme() {
  const ColorScheme scheme = ColorScheme.dark(
    primary: AppColors.amber,
    onPrimary: Color(0xFF2A1A05),
    secondary: AppColors.teal,
    onSecondary: Colors.white,
    surface: AppColors.nightSoft,
    onSurface: AppColors.text,
    error: Color(0xFFCF6679),
  );

  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: scheme,
    scaffoldBackgroundColor: AppColors.night,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.night,
      foregroundColor: AppColors.text,
      elevation: 0,
      centerTitle: true,
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: AppColors.nightSoft,
      indicatorColor: AppColors.amber.withOpacity(0.22),
    ),
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: AppColors.cardHigh,
      contentTextStyle: TextStyle(color: AppColors.text),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.card,
      hintStyle: const TextStyle(color: AppColors.textDim),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
    ),
    dividerColor: AppColors.border,
  );
}
