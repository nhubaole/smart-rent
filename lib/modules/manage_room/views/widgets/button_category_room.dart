import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';

class ButtonCategoryRoom extends StatelessWidget {
  final String title;
  final String icon;
  final Function() onTap;
  final double? height;
  final double? iconSize;
  final bool? isCommingSoon;
  const ButtonCategoryRoom({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.height,
    this.iconSize,
    this.isCommingSoon = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: height ?? 46,
      // width: height ?? 46,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          splashColor: AppColors.white.withOpacity(0.1),
          onTap: onTap,
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.white.withOpacity(0.3),
                        border: Border.all(
                          width: 0.5,
                          color: Colors.black.withOpacity(
                            0.2,
                          ),
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.4),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: icon.contains('svg')
                              ? SvgPicture.asset(
                                  icon,
                                  width: iconSize ?? 24,
                                  height: iconSize ?? 24,
                                )
                              : Image.asset(
                                  icon,
                                  width: iconSize ?? 24,
                                  height: iconSize ?? 24,
                                ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 4, right: 4),
                      child: Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              if (isCommingSoon ?? false)
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 4.px, vertical: 1.px),
                    decoration: BoxDecoration(
                      color: AppColors.error.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(100.px),
                    ),
                    child: Text(
                      'Sớm ra mắt',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
