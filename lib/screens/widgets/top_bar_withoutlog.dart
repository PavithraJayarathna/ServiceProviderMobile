import 'package:flutter/material.dart';
import '../../core/app_colors.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final VoidCallback? onBack;
  final bool automaticallyImplyLeading;

  const TopBar({
    super.key,
    this.title,
    this.onBack,
    this.automaticallyImplyLeading = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.secondary,
      elevation: 0,
      automaticallyImplyLeading: false, // control manually
      titleSpacing: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (automaticallyImplyLeading) // back arrow if true
            IconButton(
              icon: const Icon(Icons.arrow_back, color: AppColors.primary),
              onPressed: onBack ?? () => Navigator.of(context).pop(),
            )
          else
            const SizedBox(width: 28), // gap when no back arrow

          if (title != null)
            Text(
              title!,
              style: const TextStyle(
                color: AppColors.primary,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
