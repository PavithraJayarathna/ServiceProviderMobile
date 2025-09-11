import 'package:flutter/material.dart';
import '../../core/app_colors.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final IconData? prefixIcon;
  final bool isPassword; // 👈 new flag (to auto handle toggle)
  final TextInputType keyboardType;
  final String? errorText; // 👈 validation support

  const CustomTextField({
    super.key,
    required this.label,
    this.prefixIcon,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.errorText,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _controller = TextEditingController();

  bool _hasFocus = false;
  bool _hasText = false;
  bool _obscure = false; // 👈 local state for password toggle

  @override
  void initState() {
    super.initState();

    _focusNode.addListener(() {
      setState(() {
        _hasFocus = _focusNode.hasFocus;
      });
    });

    _controller.addListener(() {
      setState(() {
        _hasText = _controller.text.isNotEmpty;
      });
    });

    _obscure = widget.isPassword; // 👈 init based on `isPassword`
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isActive = _hasFocus || _hasText;

    final Color bgColor =
        isActive ? AppColors.accent.withAlpha(50) : AppColors.bg;
    final Color borderColor =
        isActive ? AppColors.accent.withAlpha(50) : AppColors.borderTransparent;

    return TextField(
      controller: _controller,
      focusNode: _focusNode,
      obscureText: _obscure,
      keyboardType: widget.keyboardType,
      cursorColor: AppColors.primary,
      style: const TextStyle(color: AppColors.textDark),
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: TextStyle(
          color: isActive ? AppColors.primary : AppColors.textMedium,
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
        ),
        prefixIcon: widget.prefixIcon != null
            ? Icon(widget.prefixIcon, color: AppColors.textMedium)
            : null,
        suffixIcon: widget.isPassword
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    _obscure = !_obscure;
                  });
                },
                child: Icon(
                  _obscure ? Icons.visibility : Icons.visibility_off,
                  color: AppColors.textMedium,
                ),
              )
            : null,

        // Background dynamic
        filled: true,
        fillColor: bgColor,

        // Borders dynamic
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: borderColor, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.accent, width: 2),
        ),

        // Validation
        errorText: widget.errorText,
      ),
    );
  }
}

