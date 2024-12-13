import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';

class TypeIndexDropdown extends StatelessWidget {
  const TypeIndexDropdown({
    super.key,
    required this.textStyle,
  });

  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.4,
      padding: EdgeInsets.all(8.px),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.px),
        border: Border.all(color: AppColors.secondary60, width: 1.px),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'period'.tr,
                style: textStyle.copyWith(
                  color: AppColors.secondary40,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.normal,
                ),
              ),
              Text('electricity'.tr, style: textStyle),
            ],
          ),
          const Spacer(),
          const Icon(
            Icons.arrow_downward_outlined,
          ),
        ],
      ),
    );
  }
}
