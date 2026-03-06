import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Brand Colors
  static const Color primary = Color(0xFFE50914);
  static const Color primaryDark = Color(0xFFB20710);
  static const Color accent = Color(0xFFFFD700);
  static const Color background = Color(0xFF0A0A0A);
  static const Color surface = Color(0xFF141414);
  static const Color surfaceVariant = Color(0xFF1F1F1F);
  static const Color cardBg = Color(0xFF1A1A2E);
  static const Color onPrimary = Colors.white;
  static const Color onBackground = Colors.white;
  static const Color onSurface = Colors.white;
  static const Color textSecondary = Color(0xFFABABAB);
  static const Color textMuted = Color(0xFF6B6B6B);
  static const Color divider = Color(0xFF2A2A2A);
  static const Color gold = Color(0xFFFFD700);
  static const Color green = Color(0xFF46D369);

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: background,
      primaryColor: primary,
      colorScheme: const ColorScheme.dark(
        primary: primary,
        secondary: accent,
        surface: surface,
        background: background,
        onPrimary: onPrimary,
        onSurface: onSurface,
        onBackground: onBackground,
      ),
      textTheme: GoogleFonts.poppinsTextTheme(
        const TextTheme(
          displayLarge:
              TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
          displayMedium:
              TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
          displaySmall:
              TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
          headlineLarge:
              TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
          headlineMedium:
              TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          headlineSmall:
              TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          titleLarge:
              TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          titleMedium:
              TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
          titleSmall:
              TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
          bodyLarge:
              TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
          bodyMedium:
              TextStyle(color: Color(0xFFABABAB), fontWeight: FontWeight.w400),
          bodySmall:
              TextStyle(color: Color(0xFF6B6B6B), fontWeight: FontWeight.w400),
          labelLarge:
              TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        foregroundColor: Colors.white,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color(0xFF0F0F0F),
        selectedItemColor: Colors.white,
        unselectedItemColor: Color(0xFF6B6B6B),
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
      iconTheme: const IconThemeData(color: Colors.white),
      dividerColor: divider,
    );
  }
}
