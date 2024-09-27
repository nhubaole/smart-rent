import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/config/app_colors.dart';
import '../../../../core/values/app_colors.dart';

class ButtonManageResource extends StatelessWidget {
  const ButtonManageResource({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });
  final Function() onTap;
  final String icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        splashColor: Colors.grey.withOpacity(0.5),
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            icon.contains('svg')
                ? SvgPicture.asset(
                    icon,
                    width: 42,
                    height: 42,
                  )
                : Image.asset(
                    icon,
                    width: 42,
                    height: 42,
                  ),
            Text(
              title,
              style: const TextStyle(
                color: AppColors.secondary20,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
