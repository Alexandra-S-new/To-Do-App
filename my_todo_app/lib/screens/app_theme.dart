import 'package:flutter/material.dart';

abstract class AppTheme {
  static const Color primaryColor = Color(0xFF00897B); // Teal
  static const Color secondaryColor = Color(0xFF80CBC4);

  static const Color backgroundColor = Color(0xFFF5F7F7);
  static const Color cardColor = Colors.white;
  static const Color cardLightColor = Color(0xFFB2DFDB);

  static const Color successColor = Color(0xFF43A047);
  static const Color warningColor = Color(0xFFFB8C00);
  static const Color errorColor = Color(0xFFE53935);

  static const Color textColor = Color(0xFF263238);
  static const Color cardDarkColor = Color(0xFF164E4A);

  //DarkTheme
  static const Color darkBackgroundColor = Color(0xFF121212);
  static const Color darkCardColor = Color.fromARGB(255, 77, 77, 77);

  static const Color primaryDarkColor = Color(0xFF26A69A);
  static const Color textDarkColor = Colors.white;

  static ThemeData lightTheme() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: backgroundColor,
      textTheme: TextTheme(
        displayLarge: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        displayMedium: TextStyle(fontSize: 28),
        displaySmall: TextStyle(fontSize: 22),
        bodyLarge: TextStyle(fontSize: 16),
        bodyMedium: TextStyle(fontSize: 14),
        labelLarge: TextStyle(fontSize: 16),
      ),
      cardTheme: CardThemeData(color: cardLightColor, elevation: 3),
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryColor,
        foregroundColor: cardColor,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: primaryColor,
        foregroundColor: cardColor,
      ),
    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryDarkColor,
        brightness: Brightness.dark,
      ),
      scaffoldBackgroundColor: darkBackgroundColor,

      cardTheme: const CardThemeData(color: cardDarkColor, elevation: 3),
      appBarTheme: const AppBarTheme(
        backgroundColor: cardDarkColor,
        foregroundColor: textDarkColor,
      ),
      textTheme: TextTheme(
        displayLarge: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        displayMedium: TextStyle(fontSize: 28),
        displaySmall: TextStyle(fontSize: 22),
        bodyLarge: TextStyle(fontSize: 16),
        bodyMedium: TextStyle(fontSize: 14),
        labelLarge: TextStyle(fontSize: 16),
      ),
    );
  }
}
