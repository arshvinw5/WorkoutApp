//light theme
import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
    brightness: Brightness.light,
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFFFDFBEE),
    ),
    scaffoldBackgroundColor: Color(0xFFFDFBEE),
    colorScheme: ColorScheme.light(
        surface: Colors.grey.shade200,
        primary: Colors.grey.shade500,
        secondary: Colors.grey.shade100,
        tertiary: Colors.white,
        inversePrimary: Colors.grey.shade900));

//dark mode
ThemeData darkMode = ThemeData(
    brightness: Brightness.dark,
    appBarTheme: AppBarTheme(backgroundColor: Colors.black),
    scaffoldBackgroundColor: Colors.black,
    colorScheme: ColorScheme.dark(
        surface: Colors.black,
        primary: Colors.grey.shade800,
        secondary: Colors.grey.shade700,
        tertiary: Colors.grey.shade600,
        inversePrimary: Colors.grey.shade300));




//FE4F2D
//Color(0xFFF0FF42)
// background : FDFBEE

//#c0f360