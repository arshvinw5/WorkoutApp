import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_app/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigationToOnboardScreen(context);
  }

  //method to navigate to onboard screen
  //method to navigate to onboard screen
  void navigationToOnboardScreen(BuildContext context) {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Center(
            child: Image.asset(
          'assets/imgs/workout.png',
          height: 400,
          width: 400,
        )),
      ),
    );
  }
}
