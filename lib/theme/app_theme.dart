import 'package:flutter/material.dart';

/// Cores e estilos centrais do aplicativo, para manter a interface
/// consistente entre as telas.
class AppTheme {
  static const Color background = Color(0xFF0F1220);
  static const Color surface = Color(0xFF1B1F34);
  static const Color primary = Color(0xFF7C6CF6);
  static const Color accent = Color(0xFF41D6C3);
  static const Color textPrimary = Color(0xFFF5F5FA);
  static const Color textSecondary = Color(0xFFA5A9C4);

  static ThemeData get themeData {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: background,
      primaryColor: primary,
      colorScheme: const ColorScheme.dark(
        primary: primary,
        secondary: accent,
        surface: surface,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: background,
        elevation: 0,
        foregroundColor: textPrimary,
        centerTitle: false,
      ),
      cardTheme: CardThemeData(
        color: surface,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      textTheme: const TextTheme(
        headlineSmall: TextStyle(
          color: textPrimary,
          fontWeight: FontWeight.bold,
        ),
        titleMedium: TextStyle(
          color: textPrimary,
          fontWeight: FontWeight.w600,
        ),
        bodyMedium: TextStyle(color: textSecondary),
      ),
      useMaterial3: true,
    );
  }
}
