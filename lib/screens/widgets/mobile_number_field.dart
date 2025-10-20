import 'package:flutter/material.dart';
import '../../core/app_colors.dart';

class MobileNumberField extends StatefulWidget {
  final String label;
  final String initialCountryCode;
  final FormFieldValidator<String>? validator;
  final AutovalidateMode? autovalidateMode;
  final ValueChanged<String>? onChanged;

  const MobileNumberField({
    super.key,
    this.label = "Mobile Number",
    this.initialCountryCode = "+94",
    this.validator,
    this.autovalidateMode,
    this.onChanged,
  });

  @override
  State<MobileNumberField> createState() => _MobileNumberFieldState();
}

class _MobileNumberFieldState extends State<MobileNumberField> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _controller = TextEditingController();

  bool _hasFocus = false;
  late String _countryCode;

  final List<String> _countryCodes = const ["+94", "+91", "+1"];

  @override
  void initState() {
    super.initState();
    _countryCode = widget.initialCountryCode;

    _focusNode.addListener(() {
      setState(() {
        _hasFocus = _focusNode.hasFocus;
      });
    });

    _controller.addListener(_notifyChange);
  }

  void _notifyChange() {
    if (widget.onChanged != null) {
      widget.onChanged!("$_countryCode${_controller.text}");
    }
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isActive = _hasFocus || _controller.text.isNotEmpty;

    final Color bgColor =
        isActive ? AppColors.accent.withAlpha(40) : AppColors.bg;
    final Color borderColor =
        isActive ? AppColors.accent : AppColors.borderTransparent;

    return Row(
      children: [
        /// Country Code Selector
        Container(
          width: 90,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: borderColor, width: 1.5),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _countryCode,
              isExpanded: true,
              items: _countryCodes
                  .map((code) =>
                      DropdownMenuItem(value: code, child: Text(code)))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _countryCode = value ?? widget.initialCountryCode;
                });
                _notifyChange();
              },
              icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
              style: const TextStyle(color: Colors.black, fontSize: 16),
            ),
          ),
        ),
        const SizedBox(width: 12),

        /// Phone Number Field
        Expanded(
          child: TextFormField(
            controller: _controller,
            focusNode: _focusNode,
            keyboardType: TextInputType.phone,
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
              prefixIcon: const Icon(Icons.phone, color: Colors.grey),
              hintText: "70 000 0000",
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
            onChanged: (val) => _notifyChange(),
          ),
        ),
      ],
    );
  }
}
