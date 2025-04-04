import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_app/data/workout_data.dart';
import 'package:workout_app/theme/theme_provider.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) => Drawer(
              child: Column(
                children: [
                  GestureDetector(
                      onTap: () =>
                          Provider.of<WorkoutData>(context, listen: false)
                              .resetDatabase(),
                      child: Container(
                        padding: const EdgeInsets.all(20.0),
                        child: const Text('Reset Database'),
                      )),
                  CupertinoSwitch(
                      value: themeProvider.isDarkMood,
                      onChanged: (value) => themeProvider.toggleTheme()),
                ],
              ),
            ));
  }
}
