import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ButtonActionNavbar extends StatelessWidget {
  final String title;
  final Function() onTap;
  final Color backgroundColor;
  final Color textColor;
  final Widget? leading;
  final EdgeInsetsGeometry? padding;
  const ButtonActionNavbar({
    super.key,
    required this.title,
    required this.onTap,
    required this.backgroundColor,
    required this.textColor,
    this.leading,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(backgroundColor),
        foregroundColor: WidgetStateProperty.all(textColor),
        padding: WidgetStateProperty.all(
          padding ??
              EdgeInsets.symmetric(
                horizontal: 16.px,
                vertical: 12.px,
              ),
        ),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              10.0,
            ),
          ),
        ),
      ),
      onPressed: onTap,
      child: Row(
        children: [
          if (leading != null)
            Row(
              children: [
                leading!,
                SizedBox(width: 8.px),
              ],
            ),
          Text(title),
        ],
      ),
    );
  }
}
