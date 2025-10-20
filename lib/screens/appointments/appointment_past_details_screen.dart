import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../widgets/top_bar_withoutlog.dart';

class AppointmentPastDetailsScreen extends StatelessWidget {
  final String? notes; // 🧠 receive doctor's notes

  const AppointmentPastDetailsScreen({super.key, this.notes});

  static const route = "/appointment_past_details";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: const TopBar(title: "Appointment Details"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🐶 Pet + Owner Info
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 28,
                  backgroundColor: AppColors.primaryLight,
                  child: Icon(Icons.pets, color: AppColors.primary),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Buddy",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      Text(
                        "Appointment for Annual Checkup",
                        style: TextStyle(color: AppColors.primary),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "👩 Sarah Johnson\n📞 077-0000000",
                        style: TextStyle(
                          color: AppColors.primary,
                          height: 1.6,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // 📋 Appointment Summary
            const Text(
              "Appointment Summary",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.bg,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.primary),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _DetailRow(
                    icon: Icons.calendar_today,
                    text: "Tuesday, August 28, 2025 at 10:00 AM",
                  ),
                  SizedBox(height: 10),
                  _DetailRow(
                    icon: Icons.assignment,
                    text: "Annual Checkup",
                  ),
                  SizedBox(height: 10),
                  _DetailRow(
                    icon: Icons.location_on,
                    text: "Happy Paws Veterinary Clinic, Colombo",
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // 🩺 Doctor Notes
            const Text(
              "Special Notes",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 8),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.bg,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.primary),
              ),
              child: Text(
                notes ?? "No special notes available.",
                style: const TextStyle(
                  color: AppColors.primary,
                  height: 1.6,
                ),
              ),
            ),

            const SizedBox(height: 32),

            // ✅ Appointment Completed Badge
            Center(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                decoration: BoxDecoration(
                  color: AppColors.success,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.success),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(
                      Icons.check_circle,
                      color: AppColors.textDark,
                      size: 24,
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Appointment Completed",
                      style: TextStyle(
                        color: AppColors.textDark,
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _DetailRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primary, size: 22),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: AppColors.textMedium,
              height: 1.5,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}
