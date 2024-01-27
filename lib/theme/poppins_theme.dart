import 'package:flutter/material.dart';

ThemeData poppinsTheme() {
  return ThemeData(
    textTheme: const TextTheme(
      bodyLarge: TextStyle(fontFamily: 'Poppins'),
      bodyMedium: TextStyle(fontFamily: 'Poppins'),
      bodySmall: TextStyle(fontFamily: 'Poppins'),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        textStyle: MaterialStateProperty.all<TextStyle>(
          const TextStyle(fontFamily: 'Poppins'),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        textStyle: MaterialStateProperty.all<TextStyle>(
          const TextStyle(fontFamily: 'Poppins'),
        ),
      ),
    ),
    primaryTextTheme: const TextTheme(
      titleLarge: TextStyle(fontFamily: 'Poppins'),
      titleMedium: TextStyle(fontFamily: 'Poppins'),
      titleSmall: TextStyle(fontFamily: 'Poppins'),
    ),
  );
}
