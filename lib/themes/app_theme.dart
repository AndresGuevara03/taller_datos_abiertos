import 'package:flutter/material.dart';

class AppTheme {
  // Palette definition
  static const Color background = Color(0xFF121418);
  static const Color surface = Color(0xFF1C1F26);
  static const Color primary = Color(0xFF00FFD1); // Neon Cyan
  static const Color secondary = Color(0xFF2D333F);
  static const Color accent = Color(0xFF00FFD1);
  
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Color(0xFF8E99A9);

  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: background,
      colorScheme: const ColorScheme.dark(
        primary: primary,
        secondary: secondary,
        surface: surface,
        onSurface: textPrimary,
        primaryContainer: Color(0xFF003D32),
        onPrimaryContainer: Colors.white,
      ),
      
      appBarTheme: const AppBarThemeData(
        backgroundColor: Colors.transparent,
        foregroundColor: textPrimary,
        centerTitle: true,
        elevation: 0,
        titleTextStyle: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w300,
          letterSpacing: 1.2,
          color: textPrimary,
        ),
      ),
      
      cardTheme: CardThemeData(
        elevation: 0,
        color: surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: BorderSide(color: Colors.white.withOpacity(0.05), width: 1),
        ),
        clipBehavior: Clip.antiAlias,
      ),

      textTheme: const TextTheme(
        headlineMedium: TextStyle(
          color: textPrimary,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
        bodyLarge: TextStyle(color: textPrimary),
        bodyMedium: TextStyle(color: textSecondary),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
        ),
      ),
    );
  }

  // Helper for Neumorphic-like decoration
  static BoxDecoration glassDecoration({
    Color? color,
    BorderRadius? borderRadius,
    bool showBorder = true,
  }) {
    return BoxDecoration(
      color: color ?? surface,
      borderRadius: borderRadius ?? BorderRadius.circular(24),
      border: showBorder 
        ? Border.all(color: Colors.white.withOpacity(0.05), width: 1)
        : null,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.3),
          blurRadius: 10,
          offset: const Offset(5, 5),
        ),
        BoxShadow(
          color: Colors.white.withOpacity(0.02),
          blurRadius: 10,
          offset: const Offset(-5, -5),
        ),
      ],
    );
  }

  // Helper for Neon/Glow decoration
  static BoxDecoration neonDecoration({
    Color? color,
    BorderRadius? borderRadius,
  }) {
    return BoxDecoration(
      color: color ?? surface,
      borderRadius: borderRadius ?? BorderRadius.circular(24),
      border: Border.all(color: primary.withOpacity(0.5), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: primary.withOpacity(0.15),
          blurRadius: 15,
          spreadRadius: 1,
        ),
      ],
    );
  }
}