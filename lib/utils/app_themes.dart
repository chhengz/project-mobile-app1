import 'package:flutter/material.dart';

class AppThemes {
  // Light theme
  static final light = ThemeData(
    primaryColor: const Color(0xFFff5722),
    scaffoldBackgroundColor: Colors.white,
    brightness: Brightness.light,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.black),
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFFff5722),
      primary: const Color(0xFFff5722),
      brightness: Brightness.light,
      surface: Colors.white,
    ),
    cardColor: Colors.white,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: Color(0xFFff5722),
      unselectedItemColor: Colors.grey,
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
          fontFamily: 'Lato', fontWeight: FontWeight.bold, fontSize: 32),
      displayMedium: TextStyle(
          fontFamily: 'Lato', fontWeight: FontWeight.bold, fontSize: 28),
      displaySmall: TextStyle(
          fontFamily: 'Lato', fontWeight: FontWeight.bold, fontSize: 24),
      bodyLarge: TextStyle(
          fontFamily: 'Lato', fontWeight: FontWeight.w400, fontSize: 16),
      bodyMedium: TextStyle(
          fontFamily: 'Lato', fontWeight: FontWeight.w400, fontSize: 14),
      labelLarge: TextStyle(
          fontFamily: 'Lato', fontWeight: FontWeight.bold, fontSize: 14),
    ),
  );

  // Dark theme
  static final dark = ThemeData(
    primaryColor: const Color(0xFFff5722),
    scaffoldBackgroundColor: const Color(0xFF121212),
    brightness: Brightness.dark,
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF121212),
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFFff5722),
      primary: const Color(0xFFff5722),
      brightness: Brightness.dark,
      surface: const Color(0xFF121212),
    ),
    cardColor: const Color(0xFF1E1E1E),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF1E1E1E),
      selectedItemColor: Color(0xFFff5722),
      unselectedItemColor: Colors.grey,
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
          fontFamily: 'Lato', fontWeight: FontWeight.bold, fontSize: 32),
      displayMedium: TextStyle(
          fontFamily: 'Lato', fontWeight: FontWeight.bold, fontSize: 28),
      displaySmall: TextStyle(
          fontFamily: 'Lato', fontWeight: FontWeight.bold, fontSize: 24),
      bodyLarge: TextStyle(
          fontFamily: 'Lato', fontWeight: FontWeight.w400, fontSize: 16),
      bodyMedium: TextStyle(
          fontFamily: 'Lato', fontWeight: FontWeight.w400, fontSize: 14),
      labelLarge: TextStyle(
          fontFamily: 'Lato', fontWeight: FontWeight.bold, fontSize: 14),
    ),
  );
}
