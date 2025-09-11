import 'package:flutter/material.dart';
import 'package:service_providers_app/screens/auth/account_security_screen.dart';
import 'package:service_providers_app/screens/auth/complete_profile_screen.dart';
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
    RegistrationOne.route: (_) => const RegistrationOne(),
    RegistrationTwo.route: (_) => const RegistrationTwo(),
    RegistrationThree.route: (_) => const RegistrationThree(),
    CompleteProfile.route: (_) => const CompleteProfile(),
    


     VerifyPhoneScreen.route: (_) => const VerifyPhoneScreen(),
    
    
  };
}