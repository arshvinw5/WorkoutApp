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
        inverseSurface: Colors.black),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.black, foregroundColor: Colors.white),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: Color(0xffFE4F2D),
    ),
    drawerTheme: DrawerThemeData(backgroundColor: Color(0xFFFDFBEE)),
    dialogTheme: DialogTheme(
      backgroundColor: Color(0xFFFDFBEE),
    ));

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
        inverseSurface: Colors.grey.shade100),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.white, foregroundColor: Colors.black),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: Color(0xFFF0FF42),
    ),
    drawerTheme: DrawerThemeData(backgroundColor: Colors.black),
    dialogTheme: DialogTheme(
      backgroundColor: Colors.black,
    ));




//FE4F2D for dat time
//Color(0xFFF0FF42)
// background : FDFBEE

//#c0f360