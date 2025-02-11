import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';

class ButtonManageResource extends StatelessWidget {
  const ButtonManageResource({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.counter,
    this.isCommingSoon = false,
  });
  final Function() onTap;
  final String icon;
  final String title;
  final int? counter;
  final bool? isCommingSoon; 

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        splashColor: Colors.grey.withOpacity(0.5),
        onTap: onTap,
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.all(4.px),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
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
                      if (counter != null && counter! > 0)
                        Positioned(
                          right: 0,
                          top: 0,
                          child: Container(
                            padding:
                                EdgeInsets.all(counter! > 10 ? 1.px : 4.px),
                            decoration: const BoxDecoration(
                              color: AppColors.error,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              counter.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                    ],
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
    );
  }
}
