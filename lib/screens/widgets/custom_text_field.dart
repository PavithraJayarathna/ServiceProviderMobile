import 'package:flutter/material.dart';
import '../../core/app_colors.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final IconData? prefixIcon;
  final bool isPassword;
  final TextInputType keyboardType;
  final String? errorText;
  final bool enabled;
  final bool readOnly;
  final IconData? icon;         
  final VoidCallback? onTap; 
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final AutovalidateMode? autovalidateMode;
  final TextEditingController? controller;

  const CustomTextField({
    Key? key,
    required this.label,
    this.prefixIcon,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.errorText,
    this.enabled = true,
    this.readOnly = false,
    this.onTap,
    this.icon,
    this.onChanged,
    this.validator,
    this.autovalidateMode,
    this.controller,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final FocusNode _focusNode = FocusNode();
  late final TextEditingController _controller;
  bool _hasFocus = false;
  bool _hasText = false;
  late bool _obscure;
  bool get _externalController => widget.controller != null;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _obscure = widget.isPassword;

    _focusNode.addListener(() {
      setState(() {
        _hasFocus = _focusNode.hasFocus;
      });
    });

    _controller.addListener(() {
      setState(() {
        _hasText = _controller.text.isNotEmpty;
      });
      if (widget.onChanged != null) widget.onChanged!(_controller.text);
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    if (!_externalController) _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isActive = _hasFocus || _hasText;
    final Color bgColor = isActive ? AppColors.accent.withAlpha(50) : AppColors.bg;
    final Color borderColor = isActive
        ? AppColors.accent.withAlpha(50)
        : AppColors.borderTransparent;

    return TextFormField(
      controller: _controller,
      focusNode: _focusNode,
      obscureText: _obscure,
      enabled: widget.enabled,
      readOnly: widget.readOnly,
      onTap: widget.onTap,
      keyboardType: widget.keyboardType,
      cursorColor: AppColors.primary,
      style: const TextStyle(color: AppColors.textDark),
      validator: widget.validator,
      autovalidateMode: widget.autovalidateMode,
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
                onTap: () => setState(() => _obscure = !_obscure),
                child: Icon(
                  _obscure ? Icons.visibility : Icons.visibility_off,
                  color: AppColors.textMedium,
                ),
              )
            : widget.icon != null
                ? Icon(widget.icon, color: AppColors.textMedium)
                : null,
        filled: true,
        fillColor: bgColor,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: borderColor, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.accent, width: 2),
        ),
        errorText: widget.errorText,
      ),
      onChanged: widget.onChanged,
    );
  }
}
