import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';

class OutlineButtonWidget extends StatelessWidget {
  final String? text;
  final Function()? onTap;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? margin;
  final double? height;
  final Widget? trailing;
  final Widget? child;
  final Widget? leading;
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
  }) : assert(text != null || child != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.zero,
      decoration: BoxDecoration(
        color: onTap == null
            ? AppColors.secondary60
            : backgroundColor ?? AppColors.transparent,
        borderRadius: BorderRadius.circular(20.px),
        border: Border.all(
          width: 1,
          color: onTap == null ? AppColors.secondary40 : AppColors.primary60,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: AppColors.primary60.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20.px),
          onTap: onTap,
          child: Container(
            height: height ?? 50,
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (leading != null) leading!,
                child ??
                    Text(
                      text!,
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: onTap == null
                            ? AppColors.white
                            : AppColors.primary60,
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
