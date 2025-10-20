import 'package:flutter/material.dart';
import '../../core/app_colors.dart';

enum IconPosition { start, end }

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isPrimary;
  final IconData? icon;
  final IconPosition iconPosition;
  final Color? textColor;
  final Color? iconColor;
  final TextStyle? textStyle;
  final Widget? iconWidget; // 👈 custom icon widget (e.g. Google logo)
  final Color? backgroundColor; // 👈 NEW: allows custom background color

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isPrimary = true,
    this.icon,
    this.iconPosition = IconPosition.start,
    this.textColor,
    this.iconColor,
    this.textStyle,
    this.iconWidget,
    this.backgroundColor, // 👈 add to constructor
  });

  @override
  Widget build(BuildContext context) {
    final Color effectiveTextColor =
        textColor ?? (isPrimary ? Colors.white : AppColors.primary);
    final Color effectiveIconColor =
        iconColor ?? (isPrimary ? Colors.white : AppColors.primary);

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ??
              (isPrimary ? AppColors.primary : AppColors.bg),
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: isPrimary
                ? BorderSide.none
                : const BorderSide(color: AppColors.primary, width: 1.5),
          ),
          elevation: 0, // keeps modern flat look
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            if (iconWidget != null) ...[
              iconWidget!,
              const SizedBox(width: 8),
            ] else if (icon != null && iconPosition == IconPosition.start) ...[
              Icon(icon, size: 20, color: effectiveIconColor),
              const SizedBox(width: 8),
            ],

            Flexible(
              child: Text(
                text,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: textStyle ??
                    TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: effectiveTextColor,
                    ),
              ),
            ),

            if (icon != null && iconPosition == IconPosition.end) ...[
              const SizedBox(width: 8),
              Icon(icon, size: 20, color: effectiveIconColor),
            ],
          ],
        ),
      ),
    );
  }
}
