import 'package:flutter/material.dart';

var appThemeData = ThemeData(
  elevatedButtonTheme: const ElevatedButtonThemeData(),
  buttonTheme: const ButtonThemeData(
    buttonColor: Color.fromARGB(255, 252, 79, 1)
  ),
  cardTheme: const CardTheme(
      color: Colors.white,

  ),
  primaryColor: const Color.fromARGB(255, 252, 79, 1),
  backgroundColor: Colors.white,
  useMaterial3: true,
  colorScheme: const ColorScheme(
    primary: Color.fromARGB(255, 252, 79, 1),
    secondary: Color.fromARGB(255, 248, 240, 240),
    brightness: Brightness.light,
    onPrimary: Colors.white,
    onSecondary: Color.fromARGB(255, 252, 79, 1),
    background: Colors.white,
    error: Colors.red,
    onError: Colors.black,
    onBackground: Colors.black,
    surface: Color.fromARGB(255, 252, 79, 1),
    onSurface: Colors.white,
  ),
);
