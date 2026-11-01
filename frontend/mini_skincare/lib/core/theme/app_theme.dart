import 'package:flutter/material.dart';

class AppTheme {
  // Primary colors matching UI design
  static const Color primaryPurple = Color(0xFF8A55D7);
  static const Color primaryLight = Color(0xFFF4EFFC);
  static const Color backgroundColor = Color(0xFFFAFAFA);
  static const Color textDark = Color(0xFF1F1F1F);
  static const Color textGrey = Color(0xFF8C8C8C);
  static const Color cardBg = Color(0xFFFFFFFF);

  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: backgroundColor,
    primaryColor: primaryPurple,
    colorScheme: const ColorScheme.light(
      primary: primaryPurple,
      surface: cardBg,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: textDark),
      titleTextStyle: TextStyle(
        color: textDark,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}