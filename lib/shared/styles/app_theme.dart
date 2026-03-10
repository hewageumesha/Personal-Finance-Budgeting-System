
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:personal_finance_budgeting_system/shared/styles/app_colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
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
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: AppColors.primaryColor,
        secondary: AppColors.accentColor,
        error: AppColors.errorColor,
        background: AppColors.backgroundColor,
        onPrimary: AppColors.onPrimaryColor,
        onSecondary: AppColors.onAccentColor,
        onError: AppColors.onErrorColor,
        onBackground: AppColors.onBackgroundColor,
        onSurface: AppColors.onSurfaceColor,
        surface: AppColors.surfaceColor,
      ),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.poppins(fontSize: 96, fontWeight: FontWeight.w300, letterSpacing: -1.5, color: AppColors.onBackgroundColor),
        displayMedium: GoogleFonts.poppins(fontSize: 60, fontWeight: FontWeight.w300, letterSpacing: -0.5, color: AppColors.onBackgroundColor),
        displaySmall: GoogleFonts.poppins(fontSize: 48, fontWeight: FontWeight.w400, color: AppColors.onBackgroundColor),
        headlineMedium: GoogleFonts.poppins(fontSize: 34, fontWeight: FontWeight.w400, letterSpacing: 0.25, color: AppColors.onBackgroundColor),
        headlineSmall: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w400, color: AppColors.onBackgroundColor),
        titleLarge: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 0.15, color: AppColors.onBackgroundColor),
        titleMedium: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.15, color: AppColors.onBackgroundColor),
        titleSmall: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1, color: AppColors.onBackgroundColor),
        bodyLarge: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5, color: AppColors.onBackgroundColor),
        bodyMedium: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25, color: AppColors.onBackgroundColor),
        labelLarge: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25, color: AppColors.onPrimaryColor),
        bodySmall: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4, color: AppColors.onBackgroundColor),
        labelSmall: GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5, color: AppColors.onBackgroundColor),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: AppColors.accentColor, width: 2.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide.none,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: AppColors.errorColor, width: 2.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: AppColors.errorColor, width: 2.0),
        ),
        labelStyle: GoogleFonts.poppins(color: AppColors.onSurfaceColor.withOpacity(0.7)),
        hintStyle: GoogleFonts.poppins(color: AppColors.onSurfaceColor.withOpacity(0.5)),
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: AppColors.primaryColor,
        textTheme: ButtonTextTheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          foregroundColor: AppColors.onPrimaryColor,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          textStyle: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primaryColor,
          textStyle: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primaryColor,
          side: BorderSide(color: AppColors.primaryColor, width: 1.5),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          textStyle: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.surfaceColor,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.surfaceColor,
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: AppColors.onSurfaceColor.withOpacity(0.6),
        selectedLabelStyle: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600),
        unselectedLabelStyle: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w500),
        type: BottomNavigationBarType.fixed,
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.primaryColor,
        contentTextStyle: GoogleFonts.poppins(color: AppColors.onPrimaryColor),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.backgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        titleTextStyle: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.onBackgroundColor),
        contentTextStyle: GoogleFonts.poppins(fontSize: 16, color: AppColors.onBackgroundColor),
      ),
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: AppColors.onSurfaceColor.withOpacity(0.9),
          borderRadius: BorderRadius.circular(4),
        ),
        textStyle: GoogleFonts.poppins(color: AppColors.surfaceColor, fontSize: 12),
      ),
    );
  }
}
