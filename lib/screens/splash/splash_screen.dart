import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../onboarding/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  static const route = "/splash";
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
void initState() {
  super.initState();
  Future.delayed(const Duration(seconds: 10), () {
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, OnboardingScreen.route);
  });
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              "assets/images/mypic.png",
              fit: BoxFit.contain,
            ),
          ),
          Positioned(
            top: 25, // distance from top
            left: 0,
            right: 0,
            child: Image.asset(
              "assets/images/logo.png",
              width: 450,
            ),
          ),
          
        ],
      ),
    );
  }
}
