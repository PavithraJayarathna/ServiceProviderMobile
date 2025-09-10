import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../widgets/progress_bar.dart'; // Import the new progress bar widget

class ContactDetailsScreen extends StatelessWidget {
  static const route = "/contact_details";
  const ContactDetailsScreen({super.key});

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
              Center(child: Image.asset("assests/images/logo.png", height: 60)),
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

              // Use the new StepProgressBar widget
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
                "Contact Details",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                "Tell us about your contact details",
                style: Theme.of(context).textTheme.bodyMedium,
              ),

              const SizedBox(height: 24),
              Row(
                children: [
                  SizedBox(
                    width: 80,
                    child: TextField(
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.flag),
                        labelText: "+94",
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.phone),
                        labelText: "0700000000",
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: "Email Address",
                  prefixIcon: const Icon(Icons.email_outlined),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.secondary.withAlpha(80),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.sms_outlined),
                    SizedBox(width: 8),
                    Expanded(
                        child: Text(
                            "We'll send an OTP to verify your number")),
                  ],
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("← Back"),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/verify_phone");
                      },
                      child: const Text("Send OTP"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
