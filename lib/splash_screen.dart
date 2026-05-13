import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart'; // Add this for Lottie support
import 'dart:async';
import 'fade_route.dart';
import 'onboarding_screen.dart'; // After splash, navigate to onboarding

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Move to onboarding screen after 3 seconds
    Timer(Duration(seconds: 4), () {
      Navigator.pushReplacement(context, FadeRoute(page: OnboardingScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 222, 113, 189), // Soft Sky Blue
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/splash_icon.json', // Make sure this is a valid Lottie .json
              height: 120,
            ),
            SizedBox(height: 20),
            Text(
              "MentalWell",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
