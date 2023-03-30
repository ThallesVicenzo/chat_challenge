import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme => ThemeData(
        primaryColor: Colors.blue,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white, fontSize: 50),
          bodyMedium: TextStyle(color: Colors.white, fontSize: 25),
          bodySmall: TextStyle(color: Colors.black, fontSize: 15),
        ),
      );
}
