import 'package:flutter/material.dart';
import '../../core/app_colors.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final VoidCallback? onBack;

  const TopBar({super.key, this.title, this.onBack});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.secondary,
      elevation: 0,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      title: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.orange),
            onPressed: onBack ?? () => Navigator.of(context).pop(),
          ),
          if (title != null)
            Text(
              title!,
              style: const TextStyle(
                color: Colors.orange,
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
