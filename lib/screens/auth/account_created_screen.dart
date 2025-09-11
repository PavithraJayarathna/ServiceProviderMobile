import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../widgets/top_bar.dart';
import '../widgets/custom_button.dart';
import 'complete_profile_screen.dart'; 


class AccountCreatedScreen extends StatelessWidget {
  static const route = "/account_created";
  const AccountCreatedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: const TopBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 32),

              // Title
              const Text(
                "FurGlo Pro",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 4),

              // Subtitle
              const Text(
                "Professional Pet Care Services",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.primary,
                ),
              ),

              const SizedBox(height: 40),

              // Green tick circle
              Center(
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: const BoxDecoration(
                    color: AppColors.success,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.check, size: 48, color: Colors.black),
                ),
              ),

              const SizedBox(height: 24),

              // Success Message
              const Text(
                "Your Account Has Been Created!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),

              const Text(
                "Start managing your services and connect with pet owners now.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.primary,
                ),
              ),

              const SizedBox(height: 32),

              // Profile Completion Box
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.accent.withAlpha(50),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Progress label
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "Profile Completion",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary,
                          ),
                        ),
                        Text(
                          "40%",
                          style: TextStyle(color: AppColors.primary),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // Progress bar
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: const LinearProgressIndicator(
                        value: 0.4,
                        color: AppColors.accent,
                        backgroundColor: AppColors.textMedium,
                        minHeight: 6,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Description + Button
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Expanded(
                          child: Text(
                            "Complete your profile for better visibility with pet owners",
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.textMedium,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        SizedBox(
                          width: 120, // Fixed width
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, CompleteProfile.route);
                            },
                            child: const Text(
                              "Complete Profile",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // ✅ Next Button
              CustomButton(
                text: "Next",
                icon: Icons.arrow_forward,
                iconPosition: IconPosition.end,
                onPressed: () {}, // <-- no navigation
              ),

              // ✅ Back to login
              const SizedBox(height: 20),
              CustomButton(
                text: "Back to Login",
                icon: Icons.arrow_back,
                iconPosition: IconPosition.start,
                onPressed: () {}, // <-- no navigation
                isPrimary: false,
                textColor: AppColors.primary,
                iconColor: AppColors.primary,
                textStyle: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
                            const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
