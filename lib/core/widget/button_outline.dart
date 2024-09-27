import 'package:flutter/material.dart';
import '../config/app_colors.dart';
import '/core/values/app_colors.dart';

class ButtonOutline extends StatelessWidget {
  const ButtonOutline({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.text,
    required this.borderColor,
    required this.borderRadius,
    this.borderWidth = 1.0, // Thêm mặc định cho độ dày viền
  });

  final void Function() onPressed;
  final Icon icon;
  final Text text;
  final Color borderColor;
  final BorderRadius borderRadius;
  final double borderWidth; // Thêm độ dày viền

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: icon,
      label: text,
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary60,
        side: BorderSide(
            color: borderColor, width: borderWidth), // Màu viền và độ dày viền
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius,
        ),
      ),
    );
  }
}
