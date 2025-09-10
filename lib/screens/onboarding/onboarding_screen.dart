import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import 'package:service_providers_app/screens/auth/personal_details_screen.dart';


class OnboardingScreen extends StatelessWidget {
  static const route = "/onboarding";
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      body: Column(
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.topCenter,
              child: Image.asset(
                "assests/images/mypic.png",
                fit: BoxFit.contain,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Welcome To",
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Image.asset(
                  "assests/images/logo.png",
                  height: 100,
                ),
                const SizedBox(height: 8),
                Text(
                  "Caring made simple, tails made happy.",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textLight,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context)=> const PersonalDetailsScreen())
                      );
                    // Navigate to login/dashboard later
                  },
                  child: const Text("Get Started"),
                ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () {},
                  child: const Text("Sign up later"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
