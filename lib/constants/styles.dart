import 'package:flutter/material.dart';

var materialAppTheme = ThemeData(
  cardTheme: CardTheme(
      color: Colors.white,
  ),
  primaryColor: const Color.fromARGB(255, 252, 79, 1),
  backgroundColor: Colors.white,
  useMaterial3: true,
  colorScheme: const ColorScheme(
    primary: Color.fromARGB(255, 252, 79, 1),
    secondary: Color.fromARGB(255, 252, 79, 1),
    brightness: Brightness.light,
    onPrimary: Color.fromARGB(255, 252, 79, 1),
    onSecondary: Color.fromARGB(255, 252, 79, 1),
    background: Colors.white,
    error: Colors.red,
    onError: Colors.black,
    onBackground: Colors.black,
    surface: Color.fromARGB(255, 252, 79, 1),
    onSurface: Colors.white,
  ),
);
