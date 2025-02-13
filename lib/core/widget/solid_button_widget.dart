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
  final Widget? icon;
  final Widget? trailing;
  final Widget? child;
  final Widget? leading;
  final BorderRadius? borderRadius;

  const SolidButtonWidget({
    super.key,
    required this.text,
    this.onTap,
    this.backgroundColor,
    this.margin,
    this.height,
    this.textStyle,
    this.padding = const EdgeInsets.all(16.0),
    this.icon,
    this.borderRadius,
    this.trailing,
    this.leading,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.zero,
      decoration: BoxDecoration(
        color: onTap == null
            ? AppColors.secondary60
            : backgroundColor ?? AppColors.primary60,
        borderRadius: borderRadius ?? BorderRadius.circular(20.px),
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
          splashColor: AppColors.secondary20.withOpacity(0.2),
          borderRadius: borderRadius ?? BorderRadius.circular(20.px),
          onTap: onTap,
          child: Container(
            height: height,
            padding: padding,
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null)
                  Row(
                    children: [
                      icon!,
                      SizedBox(width: 8.px),
                    ],
                  ),
                child ??
                    Text(
                  text,
                  style: textStyle ??
                      TextStyle(
                        fontSize: 16.sp,
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                if (trailing != null) trailing!,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
