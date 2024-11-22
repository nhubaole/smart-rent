import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';

class SolidButtonWidget extends StatelessWidget {
  final String text;
  final Function()? onTap;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? margin;
  final double? height;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? padding;

  const SolidButtonWidget({
    super.key,
    required this.text,
    this.onTap,
    this.backgroundColor,
    this.margin,
    this.height,
    this.textStyle,
    this.padding = const EdgeInsets.all(16.0),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      margin: margin ?? EdgeInsets.zero,
      decoration: BoxDecoration(
        color: onTap == null
            ? AppColors.secondary60
            : backgroundColor ?? AppColors.primary60,
        borderRadius: BorderRadius.circular(20.px),
        border: Border.all(
          width: 1,
          color: onTap == null
              ? AppColors.secondary40
              : backgroundColor ?? AppColors.primary60,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: Colors.grey.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20.px),
          onTap: onTap,
          child: Container(
            padding: padding,
            alignment: Alignment.center,
            child: Text(
              text,
              style: textStyle ??
                  TextStyle(
                    fontSize: 16.sp,
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
