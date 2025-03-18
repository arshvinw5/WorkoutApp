import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:workout_app/theme/theme.dart';

class ThemeProvider extends ChangeNotifier {
  // Open Hive box for toggle theme
  final _settingsBox = Hive.box('settingsDb');
  //initial theme mode
  //ThemeData _themeData = lightMode;

  late ThemeData _themeData;

  // Constructor to initialize the theme
  ThemeProvider() {
    bool isDark = _settingsBox.get('IS_DARK_MOOD', defaultValue: false);
    _themeData = isDark ? darkMode : lightMode;
  }

  //get the current theme
  ThemeData get themeData => _themeData;

  //is current theme dark or not
  bool get isDarkMood => _themeData == darkMode;

  // set themeData(ThemeData theme) {
  //   _themeData = theme;
  //   notifyListeners();
  // }

  // void toggleTheme() {
  //   if (_themeData == lightMode) {
  //     _themeData = darkMode;
  //   } else {
  //     _themeData = lightMode;
  //   }
  //   notifyListeners();
  // }

  //set the theme
  // Set theme and save to Hive
  set themeData(ThemeData theme) {
    _themeData = theme;
    _settingsBox.put('isDarkMode', theme == darkMode); // Save to Hive
    notifyListeners();
  }

//toggle methods to switch between two
  void toggleTheme() {
    _themeData = isDarkMood ? lightMode : darkMode;
    //Save new theme mode to hive
    _settingsBox.put('IS_DARK_MOOD', isDarkMood);
    notifyListeners();
  }
}
