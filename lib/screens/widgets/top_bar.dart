import 'package:flutter/material.dart';
import '../../core/app_colors.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  final bool showBack; 

  const TopBar({super.key, this.showBack = true}); 

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(180),
      child: AppBar(
        backgroundColor: AppColors.secondary,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: showBack, 
        iconTheme: const IconThemeData(
          color: AppColors.primary,
        ),
        title: Image.asset(
          "assets/images/logo.png",
          height: 40,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
