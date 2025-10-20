import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../widgets/custom_button.dart';
import '../widgets/top_bar_withoutlog.dart';

class AppointmentCompleteScreen extends StatelessWidget {
  final String? notes; // 🧠 receive doctor's notes

  const AppointmentCompleteScreen({super.key, this.notes});

  static const route = "/appointment_complete";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: const TopBar(title: "Appointment Complete"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),

            // ✅ Success Icon
            Container(
              width: 90,
              height: 90,
              decoration: const BoxDecoration(
                color: AppColors.success,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_rounded,
                color: AppColors.textDark,
                size: 55,
              ),
            ),

            const SizedBox(height: 24),

            // 🎉 Appointment Done Title
            const Text(
              "Appointment Done!",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Your consultation has been successfully completed",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: AppColors.primary,
              ),
            ),

            const SizedBox(height: 32),

            // 📋 Appointment Summary Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.bg,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.primary),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12.withOpacity(0.05),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _DetailItem(label: "Service Name", value: "General Checkup"),
                  SizedBox(height: 8),
                  _DetailItem(label: "Owner Name", value: "Sarah Johnson"),
                  SizedBox(height: 8),
                  _DetailItem(
                      label: "Date & Time", value: "28 Aug 2025 at 10:00 AM"),
                  SizedBox(height: 8),
                  _DetailItem(label: "Duration", value: "30 minutes"),
                ],
              ),
            ),

            const SizedBox(height: 24),

            
            if (notes != null && notes!.isNotEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.bg,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.primary),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12.withOpacity(0.05),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.note_alt_outlined,
                            color: AppColors.primary),
                        SizedBox(width: 6),
                        Text(
                          "Special Notes",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      notes!,
                      style: const TextStyle(
                        color: AppColors.textMedium,
                        fontSize: 14.5,
                        height: 1.5,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),

            const SizedBox(height: 40),

            // 🧾 Generate Invoice Button
            CustomButton(
              text: "Generate Invoice",
              onPressed: () {
                // TODO: navigate to invoice screen
              },
              isPrimary: true,
            ),

            const SizedBox(height: 12),

            // 🔙 Back to Appointments Button
            CustomButton(
              text: "Back to Appointments",
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              isPrimary: false,
            ),
          ],
        ),
      ),
    );
  }
}

// ───────────────────────────── Helper Widget ─────────────────────────────

class _DetailItem extends StatelessWidget {
  final String label;
  final String value;

  const _DetailItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "$label:",
          style: const TextStyle(
            color: AppColors.textMedium,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
