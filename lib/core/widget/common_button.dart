import 'package:flutter/material.dart';

import '../config/app_colors.dart';

class CommonButton extends StatelessWidget {
  final String title;
  final Function() onClick;
  final double? width;
  final double? height;
  final String? icon;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final double? borderRadius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  const CommonButton({
    super.key,
    required this.title,
    required this.onClick,
    this.width,
    this.height,
    this.icon,
    this.textStyle,
    this.backgroundColor,
    this.borderRadius,
    this.padding,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      // height: height ?? 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius ?? 100),
        color: backgroundColor ?? AppColors.primary60,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: Colors.grey.withOpacity(0.2),
          borderRadius: BorderRadius.circular(borderRadius ?? 100),
          onTap: onClick,
          child: Container(
            alignment: Alignment.center,
            child: Padding(
              padding: padding ?? const EdgeInsets.all(16.0),
              child: Text(
                title,
                style: textStyle ??
                    const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
