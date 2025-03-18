import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_app/theme/theme_provider.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) => Drawer(
              child: CupertinoSwitch(
                  value: themeProvider.isDarkMood,
                  onChanged: (value) => themeProvider.toggleTheme()),
            ));
  }
}
