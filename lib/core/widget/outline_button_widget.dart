import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';

class OutlineButtonWidget extends StatelessWidget {
  final String? text;
  final Function()? onTap;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final double? height;
  final Widget? trailing;
  final Widget? child;
  final Widget? leading;
  final BorderRadius? borderRadius;
  final Color? borderColor;
  final Color? textColor;
  const OutlineButtonWidget({
    super.key,
    this.text,
    this.onTap,
    this.backgroundColor,
    this.margin,
    this.height,
    this.trailing,
    this.leading,
    this.child,
    this.borderRadius,
    this.padding = const EdgeInsets.all(16.0),
    this.borderColor,
    this.textColor,
  }) : assert(text != null || child != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.zero,
      decoration: BoxDecoration(
        color: onTap == null
            ? AppColors.secondary60
            : backgroundColor ?? AppColors.transparent,
        borderRadius: borderRadius ?? BorderRadius.circular(20.px),
        border: Border.all(
          width: 1,
          color: borderColor ??
              (onTap == null ? AppColors.secondary40 : AppColors.primary60),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: AppColors.primary60.withOpacity(0.2),
          borderRadius: borderRadius ?? BorderRadius.circular(20.px),
          onTap: onTap,
          child: Container(
            height: height,
            padding: padding,
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (leading != null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      leading!,
                      SizedBox(width: 8.px),
                    ],
                  ),
                child ??
                    Text(
                      text!,
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: textColor ??
                            (onTap == null
                            ? AppColors.white
                                : AppColors.primary60),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                if (trailing != null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: 8.px),
                      trailing!,
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
