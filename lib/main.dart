import 'package:evently/core/utils/app_route.dart';
import 'package:evently/screens/home/home_screen.dart';
import 'package:evently/screens/onboarding/onboarding_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     debugShowCheckedModeBanner: false,
      routes: {
       AppRoute.onBoardingRouteName:(context)=>OnboardingScreen(),
        AppRoute.homeRouteName:(context)=>HomeScreen(),
      },
      home:  const OnboardingScreen(),
    );
  }
}

