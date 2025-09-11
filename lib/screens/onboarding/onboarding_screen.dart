import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../widgets/custom_button.dart';
import '../auth/personal_details_screen.dart';

class OnboardingScreen extends StatelessWidget {
  static const route = "/onboarding";
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      body: Stack(
        children: [
          // 🐶 Top Image
          Align(
            alignment: Alignment.topCenter,
            child: Image.asset(
              "assets/images/mypic.png",
              fit: BoxFit.contain,
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.55,
            ),
          ),

          // ⚪ White Bottom Card
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.60, // fixed usa
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween, // split top vs bottom
                children: [
                  // 🔝 Top Group
                  Column(
                    children: [
                      Text(
                        "Welcome To",
                        style: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 6),
                      Image.asset(
                        "assets/images/logo.png",
                        height: 40,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        "Caring made simple, tails made happy.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),

                  // 🔻 Bottom Group
                  Column(
                    children: [
                      CustomButton(
                        text: "Get Started",
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegistrationOne(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 12),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Sign up later",
                          style: TextStyle(
                            fontSize: 15,
                            color: AppColors.primary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
