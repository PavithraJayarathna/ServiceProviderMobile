import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../widgets/top_bar.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_button.dart';
import '../widgets/progress_bar.dart';
import 'contact_details_screen.dart';

class RegistrationOne extends StatefulWidget {
  const RegistrationOne({super.key});

  static const route = '/registration_one';

  @override
  State<RegistrationOne> createState() => _RegistrationOneState();
}

class _RegistrationOneState extends State<RegistrationOne> {
  final FocusNode _dropdownFocus = FocusNode();
  final _formKey = GlobalKey<FormState>(); // Form key for validation
  String? _selectedProfession;
  bool _hasFocus = false;

  @override
  void initState() {
    super.initState();
    _dropdownFocus.addListener(() {
      setState(() {
        _hasFocus = _dropdownFocus.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _dropdownFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isActive = _hasFocus || _selectedProfession != null;

    final Color bgColor =
        isActive ? AppColors.accent.withAlpha(50) : AppColors.bg;
    final Color borderColor =
        isActive ? AppColors.accent.withAlpha(50) : AppColors.borderTransparent;

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
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
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

                /// Step progress bar
                const StepProgressWithLabels(currentStep: 1),

                const SizedBox(height: 32),

                /// Section Title
                Text(
                  "Personal Details",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 6),
                const Text(
                  "Let’s Start Your Basic Information",
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 32),

                /// First Name
                CustomTextField(
                  label: "First Name",
                  prefixIcon: Icons.person_outline,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "⚠ Please enter your first name";
                    }
                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                const SizedBox(height: 16),

                /// Last Name
                CustomTextField(
                  label: "Last Name",
                  prefixIcon: Icons.person_outline,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "⚠ Please enter your last name";
                    }
                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                const SizedBox(height: 16),

                /// Profession Dropdown
                DropdownButtonFormField<String>(
                  focusNode: _dropdownFocus,
                  value: _selectedProfession,
                  dropdownColor: Colors.white,
                  items: const [
                    DropdownMenuItem(value: "Vet", child: Text("Vet")),
                    DropdownMenuItem(value: "Trainer", child: Text("Trainer")),
                    DropdownMenuItem(value: "Groomer", child: Text("Groomer")),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedProfession = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "⚠ Please select your profession type";
                    }
                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    labelText: "Profession Type",
                    labelStyle: TextStyle(
                      color: isActive
                          ? AppColors.primary
                          : AppColors.textMedium,
                      fontWeight:
                          isActive ? FontWeight.bold : FontWeight.normal,
                    ),
                    prefixIcon: const Icon(
                      Icons.work_outline,
                      color: AppColors.textMedium,
                    ),
                    filled: true,
                    fillColor: bgColor,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: borderColor, width: 1.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: AppColors.accent.withAlpha(50),
                        width: 2,
                      ),
                    ),
                  ),
                ),

                const Spacer(),

                /// Next Button
                CustomButton(
                  text: "Next",
                  icon: Icons.arrow_forward,
                  iconPosition: IconPosition.end,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const RegistrationTwo(),
                        ),
                      );
                    }
                  },
                  isPrimary: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
