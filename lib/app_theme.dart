import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color(0xFF5669FF);
  static const Color backgroundLight = Color(0xFFF2FEFF);
  static const Color backgroundDark = Color(0xFF101127);
  static const Color black = Color(0xFF1C1C1C);
  static const Color white = Color(0xFFFFFFFF);
  static const Color grey = Color(0xFF7B7B7B);
  static const Color red = Color(0xFFFF5659);

  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: backgroundLight,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: primary,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: white,
      unselectedItemColor: white,
    ),
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: AppTheme.backgroundLight,
      titleTextStyle: TextStyle(color: primary, fontSize: 22),
      foregroundColor: primary,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primary,
      foregroundColor: white,
      shape: CircleBorder(side: BorderSide(color: white, width: 0)),
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(
        color: grey,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: primary),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: primary),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: red),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primary,
        textStyle: TextStyle(
          fontStyle: FontStyle.italic,
          fontSize: 16,
          fontWeight: FontWeight.w500,
          decoration: TextDecoration.underline,
        ),
      ),
    ),
    textTheme: TextTheme(
      headlineSmall: TextStyle(
        color: white,
        fontSize: 24,
        fontWeight: FontWeight.w500,
      ),
      titleLarge: TextStyle(
        color: white,
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
      titleMedium: TextStyle(
        color: black,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      titleSmall: TextStyle(
        color: white,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData();
}
