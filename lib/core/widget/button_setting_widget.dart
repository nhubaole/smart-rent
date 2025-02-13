import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';

class ButtonSettingWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function()? onTap;
  final EdgeInsetsGeometry? margin;
  const ButtonSettingWidget({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.symmetric(horizontal: 16.px, vertical: 8.px),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.px),
        boxShadow: [
          BoxShadow(
            color: AppColors.secondary60.withOpacity(0.8),
            blurRadius: 1.px,
            offset: Offset(0, 1.px),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: AppColors.primary40.withOpacity(0.1),
          onTap: onTap,
          borderRadius: BorderRadius.circular(8.px),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 16.px, horizontal: 16.px),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(icon, color: AppColors.primary40, size: 24.px),
                    SizedBox(width: 10),
                    Text(
                      title,
                      style: TextStyle(
                        color: AppColors.primary40,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: AppColors.primary40,
                  size: 24.px,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
