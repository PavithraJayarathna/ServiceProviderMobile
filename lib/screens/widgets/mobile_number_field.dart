import 'package:flutter/material.dart';
import '../../core/app_colors.dart';

class MobileNumberField extends StatefulWidget {
  final String label;
  final String initialCountryCode;
  final Function(String)? onChanged;

  const MobileNumberField({
    super.key,
    this.label = "Mobile Number",
    this.initialCountryCode = "+94",
    this.onChanged,
  });

  @override
  State<MobileNumberField> createState() => _MobileNumberFieldState();
}

class _MobileNumberFieldState extends State<MobileNumberField> {
  final FocusNode _phoneFocusNode = FocusNode();
  final TextEditingController _phoneController = TextEditingController();

  bool _hasFocus = false;
  bool _hasText = false;
  late String _countryCode;

  @override
  void initState() {
    super.initState();
    _countryCode = widget.initialCountryCode;

    _phoneFocusNode.addListener(() {
      setState(() {
        _hasFocus = _phoneFocusNode.hasFocus;
      });
    });

    _phoneController.addListener(() {
      setState(() {
        _hasText = _phoneController.text.isNotEmpty;
      });
      if (widget.onChanged != null) {
        widget.onChanged!("$_countryCode${_phoneController.text}");
      }
    });
  }

  @override
  void dispose() {
    _phoneFocusNode.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isActive = _hasFocus || _hasText;
    final Color bgColor =
        isActive ? AppColors.accent.withAlpha(50) : AppColors.bg;
    final Color borderColor =
        isActive ? AppColors.accent.withAlpha(50) : AppColors.borderTransparent;

    return Row(
      children: [
        /// Country code dropdown
        Container(
          width: 90,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: borderColor, width: 1.5),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _countryCode,
              items: const [
                DropdownMenuItem(value: "+94", child: Text("+94")),
                DropdownMenuItem(value: "+91", child: Text("+91")),
                DropdownMenuItem(value: "+1", child: Text("+1")),
              ],
              onChanged: (value) {
                setState(() {
                  _countryCode = value ?? "+94";
                });
              },
              icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
              style: const TextStyle(color: Colors.grey, fontSize: 16),
            ),
          ),
        ),
        const SizedBox(width: 12),

        /// Phone number input with dynamic label
        Expanded(
          child: TextField(
            controller: _phoneController,
            focusNode: _phoneFocusNode,
            keyboardType: TextInputType.phone,
            cursorColor: AppColors.primary,
            style: const TextStyle(color: AppColors.textDark),
            decoration: InputDecoration(
              labelText: widget.label, // 👈 label ekath InputDecoration eke
              labelStyle: TextStyle(
                color: isActive ? AppColors.primary : AppColors.textMedium,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              ),
              prefixIcon: const Icon(Icons.phone, color: Colors.grey),
              hintText: "0700000000",
              hintStyle: const TextStyle(color: Colors.grey),
              filled: true,
              fillColor: bgColor,
              contentPadding: const EdgeInsets.symmetric(vertical: 14),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: borderColor, width: 1.5),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: AppColors.accent,
                  width: 2,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
