import 'package:flutter/material.dart';
import 'package:service_providers_app/screens/auth/contact_details_screen.dart';
import 'package:service_providers_app/screens/auth/personal_details_screen.dart';
import 'package:service_providers_app/screens/auth/verify_phone_screen.dart';
import '../screens/splash/splash_screen.dart';
import '../screens/onboarding/onboarding_screen.dart';



class AppRoutes {
  static const initialRoute = SplashScreen.route;

  static Map<String, WidgetBuilder> routes = {
    SplashScreen.route: (_) => const SplashScreen(),
    OnboardingScreen.route: (_) => const OnboardingScreen(),
    PersonalDetailsScreen.route: (_) => const PersonalDetailsScreen(),
    ContactDetailsScreen.route: (_) => const ContactDetailsScreen(),
     VerifyPhoneScreen.route: (_) => const VerifyPhoneScreen(),
    
    
  };
}