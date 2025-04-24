import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:workout_app/data/workout_data.dart';
import 'package:workout_app/screens/home_screen.dart';
import 'package:workout_app/screens/splash_screen.dart';
import 'package:workout_app/theme/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter(); // Initialize Hive
  await Hive.openBox(
      'workout_database_1'); // Open the Hive box for workout data
  await Hive.openBox('settingsDb'); // Open the Hive box for settings
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => WorkoutData()),
        ChangeNotifierProvider(create: (context) => ThemeProvider())
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) => MaterialApp(
          title: 'Workout Tracker',
          debugShowCheckedModeBanner: false,
          theme: themeProvider.themeData,
          home: const SplashScreen(),
        ),
      ),
    );
  }
} 




// MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(

//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const HomeScreen(),
//     );