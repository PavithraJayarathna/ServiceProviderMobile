import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/top_bar_withoutlog.dart'; // top bar import

class CompleteProfile extends StatelessWidget {
  const CompleteProfile({super.key});

  static const route = '/complete_profile';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: const TopBar(), // <-- Top bar eka use karanawa
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 16),

              // Title
              Text(
                "Complete Your Profile",
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                "Help Client find and trust you",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.primary,
                    ),
              ),
              const SizedBox(height: 32),

              // Profile picture upload
              Row(
                children: [
                  const CircleAvatar(
                    radius: 32,
                    backgroundColor: AppColors.primaryLight,
                    child: Icon(Icons.person, size: 40, color: AppColors.textLight),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.borderTransparent),
                        borderRadius: BorderRadius.circular(12),
                        color: AppColors.bg,
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.camera_alt, color: AppColors.textMedium),
                          SizedBox(width: 8),
                          Text("Upload Photo"),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // License number
              const CustomTextField(
                label: "License Number",
                prefixIcon: Icons.credit_card,
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 16),

              // Years of experience
              const CustomTextField(
                label: "Years of Experience",
                prefixIcon: Icons.calendar_today,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 32),

              // Save & Continue button
              CustomButton(
                text: "Save & Continue",
                onPressed: () {
                  // Handle Save & Continue
                },
              ),
              const SizedBox(height: 16),

              // Skip for now
              GestureDetector(
                onTap: () {
                  // Handle skip
                },
                child: Text(
                  "Skip for Now",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
