import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/config/app_colors.dart';
import '/core/values/app_colors.dart';

class ButtonCategoryRoom extends StatelessWidget {
  final String title;
  final String icon;
  final Function() onTap;
  final double? height;
  final double? iconSize;
  const ButtonCategoryRoom({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.height,
    this.iconSize,
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
          child: Container(
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
        ),
      ),
    );
  }
}
