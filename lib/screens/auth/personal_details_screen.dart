import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../widgets/progress_bar.dart';

class PersonalDetailsScreen extends StatelessWidget {
  static const route = "/personal_details";
  const PersonalDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Logo
              Center(
                child: Image.asset("assests/images/logo.png", height: 60),
              ),
              const SizedBox(height: 16),
              Center(
                child: Text(
                  "FurGlo Pro",
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                ),
              ),
              const SizedBox(height: 4),
              Center(
                child: Text(
                  "Professional Pet Care Services",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              const SizedBox(height: 32),

              // Step Progress Indicator
              StepProgressIndicator(
  currentStep: 1,
  totalSteps: 3,
  radius: 18,
  activeColor: AppColors.primary,
  inactiveColor: AppColors.border,
  lineColor: AppColors.border,
  labels: const [
    "Personal Details",
    "Professional Details",
    "Account Security",
  ],
),

              const SizedBox(height: 32),

              Text(
                "Personal Details",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                "Let's Start Your Basic Information",
                style: Theme.of(context).textTheme.bodyMedium,
              ),

              const SizedBox(height: 24),
              TextField(
                decoration: InputDecoration(
                  labelText: "First Name",
                  prefixIcon: const Icon(Icons.person_outline),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: "Last Name",
                  prefixIcon: const Icon(Icons.person_outline),
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: "Select Your Profession Type",
                  prefixIcon: Icon(Icons.badge_outlined),
                ),
                items: const [
                  DropdownMenuItem(value: "vet", child: Text("Veterinarian")),
                  DropdownMenuItem(value: "trainer", child: Text("Trainer")),
                ],
                onChanged: (v) {},
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/contact_details");
                },
                child: const Text("Next  →"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

