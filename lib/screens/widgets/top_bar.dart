import 'package:flutter/material.dart';
import '../../core/app_colors.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  const TopBar({super.key});

  @override
Widget build(BuildContext context) {
  return PreferredSize(
    preferredSize: const Size.fromHeight(180), // custom height
    child: AppBar(
      backgroundColor: AppColors.secondary,
      elevation: 0,
      centerTitle: true,
      title: Image.asset(
        "assets/images/logo.png",
        height: 40,
        // AppBar height එකට අනුකූල
        fit: BoxFit.contain,
      ),
    ),
  );
}

  // AppBar size (status bar + app bar height)
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
