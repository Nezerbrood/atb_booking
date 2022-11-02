import 'package:flutter/material.dart';

var appThemeData = ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Color.fromARGB(255, 252, 79, 1),

    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        textStyle: MaterialStatePropertyAll(TextStyle(
          fontSize: 21,
          color: Color.fromARGB(255, 0, 0, 255),
        )),
      ),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: Color.fromARGB(255, 252, 79, 1), //  <-- dark color
      textTheme:
          ButtonTextTheme.accent, //  <-- this auto selects the right color
    ),
    cardTheme: const CardTheme(
      shadowColor: Colors.black,
      color: Colors.white,
    ),
    primaryColor: const Color.fromARGB(255, 252, 79, 1),
    backgroundColor: Colors.white,
    useMaterial3: true,
    textTheme: const TextTheme(
      /// В приложении должны использоваться только стили определенные ниже
      /// Используй их appThemeData.textTheme.*TextStyleName*
      displayLarge:
          TextStyle(fontSize: 57, color: Color.fromARGB(255, 116, 116, 117)),
      displayMedium:
          TextStyle(fontSize: 45, color: Color.fromARGB(255, 116, 116, 117)),
      displaySmall:
          TextStyle(fontSize: 36, color: Color.fromARGB(255, 116, 116, 117)),

      headlineLarge:
          TextStyle(fontSize: 32, color: Color.fromARGB(255, 116, 116, 117)),
      headlineMedium:
          TextStyle(fontSize: 28, color: Color.fromARGB(255, 116, 116, 117)),
      headlineSmall:
          TextStyle(fontSize: 24, color: Color.fromARGB(255, 116, 116, 117)),

      titleLarge: TextStyle(fontSize: 22),
      titleMedium: TextStyle(fontSize: 17),
      titleSmall:
          TextStyle(fontSize: 15, color: Color.fromARGB(255, 116, 116, 117)),

      labelLarge: TextStyle(fontSize: 14),
      labelMedium: TextStyle(fontSize: 12),
      labelSmall: TextStyle(fontSize: 11),

      bodyLarge: TextStyle(fontSize: 17),
      bodyMedium: TextStyle(fontSize: 14),
      bodySmall: TextStyle(fontSize: 12),

      /// используй код ниже чтобы быстро проверить все стилли
      // Text("Lorem Ипсум",style: appThemeData.textTheme.displayLarge,),
      // Text("Lorem Ипсум",style: appThemeData.textTheme.displayMedium,),
      // Text("Lorem Ипсум",style: appThemeData.textTheme.displaySmall,),
      // Text("Lorem Ипсум",style: appThemeData.textTheme.titleLarge,),
      // Text("Lorem Ипсум",style: appThemeData.textTheme.titleMedium,),
      // Text("Lorem Ипсум",style: appThemeData.textTheme.titleSmall,),
      // Text("Lorem Ипсум",style: appThemeData.textTheme.headlineLarge,),
      // Text("Lorem Ипсум",style: appThemeData.textTheme.headlineMedium,),
      // Text("Lorem Ипсум",style: appThemeData.textTheme.headlineSmall,),
      // Text("Lorem Ипсум",style: appThemeData.textTheme.labelLarge,),
      // Text("Lorem Ипсум",style: appThemeData.textTheme.labelMedium,),
      // Text("Lorem Ипсум",style: appThemeData.textTheme.labelSmall,),
      // Text("Lorem Ипсум",style: appThemeData.textTheme.bodyLarge,),
      // Text("Lorem Ипсум",style: appThemeData.textTheme.bodyMedium,),
      // Text("Lorem Ипсум",style: appThemeData.textTheme.bodySmall,),
    ),
    colorScheme: const ColorScheme(
      shadow: Colors.black26,
      primary: Color.fromARGB(255, 248, 240, 240),
      secondary: Color.fromARGB(255, 248, 240, 240),
      brightness: Brightness.light,
      onPrimary: Colors.white,
      onSecondary: Color.fromARGB(255, 252, 79, 1),
      background: Colors.white,
      error: Colors.red,
      onError: Colors.black,
      onBackground: Colors.black,
      surface: Color.fromARGB(255, 252, 79, 1),
      onSurface: Colors.white,)
    );
