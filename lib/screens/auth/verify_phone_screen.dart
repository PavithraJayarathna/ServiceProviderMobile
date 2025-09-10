import 'package:flutter/material.dart';
import '../../core/app_colors.dart';

class VerifyPhoneScreen extends StatelessWidget {
  static const route = "/verify_phone";
  const VerifyPhoneScreen({super.key});

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
            const Icon(Icons.phone_android, size: 80, color: AppColors.primary),
            const SizedBox(height: 16),
            Text(
              "Verify Your Mobile Number",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 4),
            const Text("Enter the 6-digit code sent to"),
            const SizedBox(height: 4),
            const Text("+940000000000"),
            const SizedBox(height: 24),

            // OTP input boxes
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(6, (index) {
                return SizedBox(
                  width: 40,
                  child: TextField(
                    textAlign: TextAlign.center,
                    maxLength: 1,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(counterText: ""),
                  ),
                );
              }),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {},
              child: const Text("Resend OTP"),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                // Navigate to Dashboard after verification
              },
              child: const Text("Verify & Continue"),
            )
          ],
        ),
      ),
    );
  }
}
