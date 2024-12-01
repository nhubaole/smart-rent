import 'package:flutter/material.dart';

import '../config/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final Color? backgroundColor;
  final List<Widget>? actions;

  const CustomAppBar({
    super.key,
    required this.title,
    this.showBackButton = true,
    this.backgroundColor,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          color: AppColors.primary40,
          fontWeight: FontWeight.w700,
        ),
      ),
      leading: showBackButton
          ? IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
            )
          : null,
      backgroundColor: backgroundColor ?? Colors.white,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
