import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../widgets/top_bar.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_button.dart';
import '../widgets/progress_bar.dart';
import 'account_created_screen.dart'; // ⬅️ Success screen

class RegistrationThree extends StatefulWidget {
  const RegistrationThree({super.key});

  static const route = '/registration_three';

  @override
  State<RegistrationThree> createState() => _RegistrationThreeState();
}

class _RegistrationThreeState extends State<RegistrationThree> {
  bool agreed = false;
  String password = "";

  int getPasswordStrength(String pass) {
    int strength = 0;

    // Conditions
    if (pass.length >= 8) strength++;
    if (RegExp(r'[A-Z]').hasMatch(pass)) strength++;
    if (RegExp(r'[a-z]').hasMatch(pass)) strength++;
    if (RegExp(r'[0-9]').hasMatch(pass)) strength++;
    if (RegExp(r'[!@#\$&*~^%+=.?_-]').hasMatch(pass)) strength++;

    return strength; // range 0–5
  }

  @override
  Widget build(BuildContext context) {
    int strength = getPasswordStrength(password);

    // Strength colors & labels
    Color strengthColor;
    String strengthText;

    if (strength == 0) {
      strengthColor = AppColors.textMedium;
      strengthText = "";
    } else if (strength < 3) {
      strengthColor = AppColors.secondary;
      strengthText = "Weak";
    } else if (strength < 5) {
      strengthColor = AppColors.primary;
      strengthText = "Medium";
    } else {
      strengthColor = AppColors.success;
      strengthText = "Strong";
    }

    return Scaffold(
      backgroundColor: AppColors.secondary,
      appBar: const TopBar(),
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

              /// 🔹 Step progress bar (now step 3)
              const StepProgressWithLabels(currentStep: 3),

              const SizedBox(height: 32),

              /// 🔹 Section Title
              Text(
                "Account Security",
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 4),
              const Text(
                "Secure your account with strong password",
                style: TextStyle(color: AppColors.primary),
              ),

              const SizedBox(height: 24),

              /// Password field with onChanged
              CustomTextField(
                label: "Password",
                prefixIcon: Icons.lock,
                isPassword: true,
                onChanged: (val) {
                  setState(() {
                    password = val;
                  });
                },
              ),

              /// Strength bar + label
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: LinearProgressIndicator(
                      value: (strength / 5),
                      minHeight: 6,
                      borderRadius: BorderRadius.circular(4),
                      backgroundColor: Colors.grey[300],
                      valueColor: AlwaysStoppedAnimation(strengthColor),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    strengthText,
                    style: TextStyle(
                      color: strengthColor,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),

              const SizedBox(height: 16),

              /// Confirm password
              const CustomTextField(
                label: "Confirm Password",
                prefixIcon: Icons.lock,
                isPassword: true,
              ),

              const SizedBox(height: 16),

              /// Terms & Conditions checkbox
              Row(
                children: [
                  Checkbox(
                    value: agreed,
                    onChanged: (value) {
                      setState(() {
                        agreed = value ?? false;
                      });
                    },
                    activeColor: AppColors.primary,
                  ),
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                        text: "I agree to the ",
                        style: const TextStyle(color: AppColors.textMedium),
                        children: [
                          TextSpan(
                            text: "Terms & Condition",
                            style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const TextSpan(text: " and "),
                          TextSpan(
                            text: "Privacy Policy",
                            style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),

              const Spacer(),

              /// 🔹 Action Buttons
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      text: "Back",
                      icon: Icons.arrow_back,
                      iconPosition: IconPosition.start,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      isPrimary: false,
                      textColor: AppColors.primary,
                      iconColor: AppColors.primary,
                      textStyle: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: CustomButton(
                      text: "Create Account",
                      icon: Icons.arrow_forward,
                      iconPosition: IconPosition.end,
                      onPressed: agreed
                          ? () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      const AccountCreatedScreen(),
                                ),
                              );
                            }
                          : () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    "Please agree to Terms & Conditions.",
                                  ),
                                ),
                              );
                            },
                      textStyle: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              /// Divider with "or"
              Row(
                children: [
                  const Expanded(
                    child: Divider(thickness: 1, color: AppColors.primary),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      "or",
                      style: TextStyle(color: AppColors.primary),
                    ),
                  ),
                  const Expanded(
                    child: Divider(thickness: 1, color: AppColors.primary),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              /// Sign Up with Google
              CustomButton(
                text: "Sign Up With Google",
                onPressed: () {},
                isPrimary: false,
                textColor: AppColors.primary,
                iconWidget: Image.asset(
                  "assets/images/Google.png",
                  height: 20,
                  width: 20,
                ),
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
