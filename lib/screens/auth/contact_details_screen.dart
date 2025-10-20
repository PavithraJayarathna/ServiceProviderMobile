import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../widgets/top_bar.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_button.dart';
import '../widgets/progress_bar.dart';
import '../widgets/mobile_number_field.dart';
import 'verify_phone_screen.dart';

class RegistrationTwo extends StatefulWidget {
  const RegistrationTwo({super.key});

  static const route = '/registration_two';

  @override
  State<RegistrationTwo> createState() => _RegistrationTwoState();
}

class _RegistrationTwoState extends State<RegistrationTwo> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      appBar: const TopBar(showBack: false),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: AppColors.bg,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction, // ✅ auto validate
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /// 🔹 App Title & Subtitle
                Text(
                  "FurGlo Pro",
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                const Text(
                  "Professional Pet Care Services",
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 24),

                /// 🔹 Step progress bar
                const StepProgressWithLabels(currentStep: 2),

                const SizedBox(height: 32),

                /// 🔹 Section Title
                Text(
                  "Contact Details",
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 4),
                const Text(
                  "Tell us about your contact details",
                  style: TextStyle(color: AppColors.primary),
                ),

                const SizedBox(height: 24),

                /// 🔹 Mobile Number (with validation)
                MobileNumberField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "⚠ Please enter your mobile number";
                    }
                    if (value.length < 10) {
                      return "⚠ Please enter a valid mobile number";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                /// 🔹 Email Address (with validation)
                CustomTextField(
                  label: "Email Address",
                  prefixIcon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "⚠ Please enter your email address";
                    }
                    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                    if (!emailRegex.hasMatch(value)) {
                      return "⚠ Please enter a valid email";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                /// 🔹 Info Box (OTP message)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.accent.withAlpha(20),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.smartphone, color: Colors.teal, size: 20),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          "We'll send an OTP to verify your number",
                          style: TextStyle(
                            color: AppColors.textLight,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const Spacer(),

                /// 🔹 Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        text: "Back",
                        icon: Icons.arrow_back,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        isPrimary: false,
                        textColor: AppColors.primary,
                        iconColor: AppColors.primary,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: CustomButton(
                        text: "Send OTP",
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const VerifyPhoneScreen(),
                              ),
                            );
                          }
                        },
                        isPrimary: true,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
