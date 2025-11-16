import 'package:flutter/material.dart';

class AppTheme {
  // Purple color scheme sesuai website Django
  static const Color purple600 = Color(0xFF7C3AED); // --brand
  static const Color purple700 = Color(0xFF6D28D9); // --brand-700
  static const Color purple50 = Color(0xFFF5F3FF); // --brand-50
  static const Color purple100 = Color(0xFFE9D5FF); // purple-100
  static const Color purple300 = Color(0xFFC4B5FD); // --ring
  
  // Background colors
  static const Color bgStart = Color(0xFFFAF7FF); // #faf7ff
  static const Color bgEnd = Color(0xFFFFFFFF); // #ffffff
  
  // Text colors
  static const Color textPrimary = Color(0xFF111827); // gray-900
  static const Color textMuted = Color(0xFF6B7280); // gray-500
  
  // Shadow colors
  static Color shadow1 = const Color(0xFF8B5CF6).withOpacity(0.35);
  static Color shadow2 = const Color(0xFF8B5CF6).withOpacity(0.18);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: purple600,
        primary: purple600,
        secondary: purple700,
        surface: Colors.white,
      ),
      scaffoldBackgroundColor: bgStart,
      appBarTheme: const AppBarTheme(
        backgroundColor: purple600,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          fontFamily: 'Plus Jakarta Sans',
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: purple100, width: 1),
        ),
        color: Colors.white.withOpacity(0.82),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: purple600,
          foregroundColor: Colors.white,
          elevation: 4,
          shadowColor: shadow1,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontFamily: 'Plus Jakarta Sans',
          fontWeight: FontWeight.bold,
          color: textPrimary,
        ),
        displayMedium: TextStyle(
          fontFamily: 'Plus Jakarta Sans',
          fontWeight: FontWeight.bold,
          color: textPrimary,
        ),
        titleLarge: TextStyle(
          fontFamily: 'Plus Jakarta Sans',
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
        titleMedium: TextStyle(
          fontFamily: 'Plus Jakarta Sans',
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
        bodyLarge: TextStyle(
          fontFamily: 'Plus Jakarta Sans',
          color: textPrimary,
        ),
        bodyMedium: TextStyle(
          fontFamily: 'Plus Jakarta Sans',
          color: textMuted,
        ),
      ),
    );
  }

  // Gradient background seperti website
  static BoxDecoration get gradientBackground {
    return const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [bgStart, bgEnd],
      ),
    );
  }

  // Glass morphism effect
  static BoxDecoration get glassCard {
    return BoxDecoration(
      color: Colors.white.withOpacity(0.82),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: purple100, width: 1),
      boxShadow: [
        BoxShadow(
          color: shadow1,
          blurRadius: 20,
          offset: const Offset(0, 10),
        ),
        BoxShadow(
          color: shadow2,
          blurRadius: 6,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }

  // Purple gradient button
  static BoxDecoration get purpleGradientButton {
    return BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFF8B5CF6), purple600],
      ),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(
        color: purple600.withOpacity(0.28),
        width: 1,
      ),
      boxShadow: [
        BoxShadow(
          color: shadow1,
          blurRadius: 24,
          offset: const Offset(0, 8),
        ),
      ],
    );
  }
}

