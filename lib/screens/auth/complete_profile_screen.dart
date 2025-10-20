import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../core/app_colors.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/top_bar_withoutlog.dart'; // top bar import

class CompleteProfile extends StatefulWidget {
  const CompleteProfile({super.key});

  static const route = '/complete_profile';

  @override
  State<CompleteProfile> createState() => _CompleteProfileState();
}

class _CompleteProfileState extends State<CompleteProfile> {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(
      source: source,
      imageQuality: 80, // compress little
    );

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  /// Show picker as CENTER dialog with close button
  void _showPickerOptions() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          titlePadding:
              const EdgeInsets.only(left: 16, right: 8, top: 12, bottom: 0),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Choose Option",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary, // ✅ primary color
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close, color: Colors.red),
                onPressed: () {
                  Navigator.pop(context); // close dialog
                },
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading:
                    Icon(Icons.photo_library, color: AppColors.accent), // ✅ accent
                title: const Text("Gallery"),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading:
                    Icon(Icons.camera_alt, color: AppColors.secondary), // ✅ secondary
                title: const Text("Camera"),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: const TopBar(),
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
                  CircleAvatar(
                    radius: 32,
                    backgroundColor: AppColors.primaryLight,
                    backgroundImage: _image != null ? FileImage(_image!) : null,
                    child: _image == null
                        ? const Icon(Icons.person,
                            size: 40, color: AppColors.textLight)
                        : null,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: GestureDetector(
                      onTap: _showPickerOptions,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 14),
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: AppColors.borderTransparent),
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
