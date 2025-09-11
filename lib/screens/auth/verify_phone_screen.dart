import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import 'account_security_screen.dart'; // Import RegistrationThree screen

class VerifyPhoneScreen extends StatefulWidget {
  static const route = "/verify_phone";
  const VerifyPhoneScreen({super.key});

  @override
  State<VerifyPhoneScreen> createState() => _VerifyPhoneScreenState();
}

class _VerifyPhoneScreenState extends State<VerifyPhoneScreen> {
  static const Color primaryLight = Color(0xFFFFEADB);

  // Controllers for OTP text fields (6 fields)
  final List<TextEditingController> _controllers =
      List.generate(6, (_) => TextEditingController());

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  // Submit OTP and navigate to RegistrationThree
  void _submitOtp() {
    final otp = _controllers.map((c) => c.text).join();
    debugPrint("Entered OTP: $otp"); // debug

    // Navigate to RegistrationThree screen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const RegistrationThree()),
    );
  }

  void _resendOtp() {
    debugPrint("Resend OTP triggered");
    // TODO: Add backend call to resend OTP
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        backgroundColor: AppColors.secondary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Back"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 24),

            // Circle with Icon
            Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                color: primaryLight,
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Icon(
                  Icons.phone_android,
                  size: 50,
                  color: AppColors.accent,
                ),
              ),
            ),

            const SizedBox(height: 16),
            Text(
              "Verify Your Mobile Number",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 4),
            const Text(
              "Enter the 6-digit code sent to",
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              "+940000000000",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 32),

            // OTP input boxes (6 digits)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(6, (index) {
                return SizedBox(
                  width: 52,
                  child: TextField(
                    controller: _controllers[index],
                    textAlign: TextAlign.center,
                    maxLength: 1,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.bg,
                      counterText: "",
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(
                          color: AppColors.primary,
                          width: 2,
                        ),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(
                          color: AppColors.primary,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),

            const SizedBox(height: 16),
            TextButton(
              onPressed: _resendOtp,
              child: const Text("Resend OTP"),
            ),
            const SizedBox(height: 16),

            // Verify & Continue button
            ElevatedButton(
              onPressed: _submitOtp,
              child: const Text("Verify & Continue"),
            ),
          ],
        ),
      ),
    );
  }
}
