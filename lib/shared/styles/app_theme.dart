import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:personal_finance_budgeting_system/shared/styles/app_colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: AppColors.primaryColor,
      scaffoldBackgroundColor: AppColors.backgroundColor,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.onPrimaryColor,
        elevation: 0,
        titleTextStyle: GoogleFonts.poppins(
          color: AppColors.onPrimaryColor,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryColor,
        brightness: Brightness.light,
        primary: AppColors.primaryColor,
        secondary: AppColors.accentColor,
        error: AppColors.errorColor,
        surface: AppColors.backgroundColor,
        onPrimary: AppColors.onPrimaryColor,
        onSecondary: AppColors.onAccentColor,
        onError: AppColors.onErrorColor,
        onSurface: AppColors.onBackgroundColor,
      ),
      textTheme: _textTheme(AppColors.onBackgroundColor),
      inputDecorationTheme: _inputDecorationTheme(AppColors.surfaceColor, AppColors.onSurfaceColor),
      elevatedButtonTheme: _elevatedButtonTheme(),
      cardTheme: _cardTheme(AppColors.surfaceColor),
      bottomNavigationBarTheme: _bottomNavigationBarTheme(AppColors.surfaceColor, AppColors.onSurfaceColor),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: AppColors.primaryColor,
      scaffoldBackgroundColor: AppColors.darkBackgroundColor,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.darkSurfaceColor,
        foregroundColor: AppColors.darkOnSurfaceColor,
        elevation: 0,
        titleTextStyle: GoogleFonts.poppins(
          color: AppColors.darkOnSurfaceColor,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryColor,
        brightness: Brightness.dark,
        primary: AppColors.primaryColor,
        secondary: AppColors.accentColor,
        error: AppColors.errorColor,
        surface: AppColors.darkBackgroundColor,
        onPrimary: AppColors.onPrimaryColor,
        onSecondary: AppColors.onAccentColor,
        onError: AppColors.onErrorColor,
        onSurface: AppColors.darkOnBackgroundColor,
      ),
      textTheme: _textTheme(AppColors.darkOnBackgroundColor),
      inputDecorationTheme: _inputDecorationTheme(AppColors.darkSurfaceColor, AppColors.darkOnSurfaceColor),
      elevatedButtonTheme: _elevatedButtonTheme(),
      cardTheme: _cardTheme(AppColors.darkSurfaceColor),
      bottomNavigationBarTheme: _bottomNavigationBarTheme(AppColors.darkSurfaceColor, AppColors.darkOnSurfaceColor),
    );
  }

  static TextTheme _textTheme(Color textColor) {
    return TextTheme(
      displayLarge: GoogleFonts.poppins(fontSize: 96, fontWeight: FontWeight.w300, letterSpacing: -1.5, color: textColor),
      displayMedium: GoogleFonts.poppins(fontSize: 60, fontWeight: FontWeight.w300, letterSpacing: -0.5, color: textColor),
      displaySmall: GoogleFonts.poppins(fontSize: 48, fontWeight: FontWeight.w400, color: textColor),
      headlineMedium: GoogleFonts.poppins(fontSize: 34, fontWeight: FontWeight.w400, letterSpacing: 0.25, color: textColor),
      headlineSmall: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w400, color: textColor),
      titleLarge: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 0.15, color: textColor),
      titleMedium: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.15, color: textColor),
      titleSmall: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1, color: textColor),
      bodyLarge: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5, color: textColor),
      bodyMedium: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25, color: textColor),
      labelLarge: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25, color: AppColors.onPrimaryColor),
      bodySmall: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4, color: textColor),
      labelSmall: GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5, color: textColor),
    );
  }

  static InputDecorationTheme _inputDecorationTheme(Color fillColor, Color textColor) {
    return InputDecorationTheme(
      filled: true,
      fillColor: fillColor,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0), borderSide: BorderSide.none),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0), borderSide: const BorderSide(color: AppColors.accentColor, width: 2.0)),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0), borderSide: BorderSide.none),
      labelStyle: GoogleFonts.poppins(color: textColor.withAlpha(178)),
      hintStyle: GoogleFonts.poppins(color: textColor.withAlpha(128)),
    );
  }

  static ElevatedButtonThemeData _elevatedButtonTheme() {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.onPrimaryColor,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        textStyle: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  static CardThemeData _cardTheme(Color cardColor) {
    return CardThemeData(
      color: cardColor,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    );
  }

  static BottomNavigationBarThemeData _bottomNavigationBarTheme(Color bgColor, Color unselectedColor) {
    return BottomNavigationBarThemeData(
      backgroundColor: bgColor,
      selectedItemColor: AppColors.primaryColor,
      unselectedItemColor: unselectedColor.withAlpha(153),
      type: BottomNavigationBarType.fixed,
    );
  }
}
