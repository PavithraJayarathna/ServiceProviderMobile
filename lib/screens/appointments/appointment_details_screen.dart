import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../widgets/custom_button.dart';
import '../widgets/top_bar_withoutlog.dart';
import '../appointments/appointment_complete_screen.dart';

class AppointmentDetailsScreen extends StatefulWidget {
  const AppointmentDetailsScreen({super.key});

  static const route = "/appointment_details";

  @override
  State<AppointmentDetailsScreen> createState() =>
      _AppointmentDetailsScreenState();
}

class _AppointmentDetailsScreenState extends State<AppointmentDetailsScreen> {
  final TextEditingController _notesController = TextEditingController();

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
            // 🐶 Pet and Owner Info
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
                    children: [
                      const Text(
                        "Buddy",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      const Text(
                        "Appointment for Annual Checkup",
                        style: TextStyle(color: AppColors.primary),
                      ),
                      const SizedBox(height: 3),
                      const Text(
                        "Sarah Johnson\n077-0000000",
                        style: TextStyle(
                          color: AppColors.primary,
                          height: 1.3,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          foregroundColor: AppColors.primary,
                          padding: EdgeInsets.zero,
                          minimumSize: const Size(0, 0),
                        ),
                        child: const Text(
                          "View Pet Profile",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            fontStyle: FontStyle.italic,
                            decoration: TextDecoration.underline,
                            decorationColor: AppColors.primary,
                            decorationThickness: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // 📞 Call and WhatsApp Buttons
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    text: "Call",
                    icon: Icons.call,
                    onPressed: () {},
                    backgroundColor: AppColors.primary,
                    textColor: Colors.white,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: CustomButton(
                    text: "WhatsApp",
                    icon: Icons.chat,
                    onPressed: () {},
                    isPrimary: false,
                    backgroundColor: AppColors.primaryLight,
                    textColor: AppColors.primary,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // 📋 Appointment Details
            const Text(
              "Details",
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
                  SizedBox(height: 8),
                  _DetailRow(
                    icon: Icons.assignment,
                    text: "Annual Checkup",
                  ),
                  SizedBox(height: 8),
                  _DetailRow(
                    icon: Icons.location_on,
                    text: "123 Maple Street, Anytown, CA 90210",
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // 📝 Owner Notes / Notes Section (Readonly)
            const Text(
              "Notes",
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
              child: const Text(
                "Buddy has sensitive skin, use hypoallergenic shampoo only. "
                "He is usually calm but gets anxious around new sounds.",
                style: TextStyle(color: AppColors.textLight, height: 1.5),
              ),
            ),

            const SizedBox(height: 24),

            // 🩺 Special Notes (Doctor Input)
            Row(
              children: const [
                Icon(Icons.note_alt_outlined, color: AppColors.primary),
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
            const SizedBox(height: 12),

            // ✍️ Notes Input Box (No Border, Filled)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.bg.withOpacity(0.05), // soft tinted bg
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: .08),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: TextField(
                controller: _notesController,
                maxLines: 5,
                decoration: const InputDecoration(
                  hintText: "Add your notes about the consultation...",
                  hintStyle: TextStyle(color: AppColors.textLight),
                  border: InputBorder.none,
                  filled: true,
                  fillColor: AppColors.bg, // background color
                ),
                style: const TextStyle(
                  color: AppColors.textMedium,
                  height: 1.5,
                  fontSize: 14.5,
                ),
              ),
            ),

            const SizedBox(height: 32),

            // ✅ Mark Complete Button
            CustomButton(
              text: "Mark Complete",
              onPressed: () {
                final notes = _notesController.text;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        AppointmentCompleteScreen(notes: notes),
                  ),
                );
              },
              isPrimary: true,
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
        Icon(icon, color: AppColors.primary, size: 20),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: AppColors.textMedium,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}
