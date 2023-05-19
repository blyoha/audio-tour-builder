import 'package:flutter/material.dart';

class AppColors {
  static Color primary = const Color(0xFFBAE1E8);
  static Color textPrimary = const Color(0xFF333333);
  static Color textSecondary = const Color(0xFFD9D9D9);
  static Color background = const Color(0xFFF5F8F7);
  static Color error = const Color(0xFFFA3A3A);
}

class AppTextStyles {
  static TextStyle text1 = const TextStyle(
    fontSize: 18,
  );

  static TextStyle cardHeader = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w500,
  );
}

TextTheme appTextTheme() => TextTheme(
      // titleLarge: TextStyle(),
      bodyMedium: TextStyle(
        fontSize: 16,
        color: AppColors.textPrimary,
      ),
      labelLarge: TextStyle(
        fontSize: 20.0,
        color: AppColors.primary,
      ),
    );

ThemeData appTheme() => ThemeData(
      brightness: Brightness.light,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.background,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.primary,
        selectedItemColor: AppColors.primary,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textPrimary,
      ),
      fontFamily: 'Lato',
      cardTheme: CardTheme(
        color: AppColors.background,
        shadowColor: AppColors.textPrimary,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      textTheme: appTextTheme(),
      appBarTheme: AppBarTheme(
        titleTextStyle: TextStyle(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w700,
          fontSize: 22,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: AppColors.textPrimary,
      ),
    );
