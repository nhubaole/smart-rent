import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/core/values/image_assets.dart';
import 'package:smart_rent/core/widget/cache_image_widget.dart';

class StatusRequestRent extends StatelessWidget {
  final bool isLandlord;
  final int sumQuantityRequest;
  final Function() onTap;

  const StatusRequestRent({
    super.key,
    required this.sumQuantityRequest,
    required this.onTap,
    required this.isLandlord,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.grey.withOpacity(0.5),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(16.px),
          bottomRight: Radius.circular(16.px),
        ),
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.only(
            top: 16.px,
            right: 16.px,
            left: 16.px,
            bottom: 16.px,
          ),
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(color: AppColors.secondary80, width: 1),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              if (isLandlord)
                Row(
                  children: [
                    SizedBox(width: 8.px),
                    ClipOval(
                      child: CacheImageWidget(
                        imageUrl: ImageAssets.demo,
                        width: 6.h,
                        height: 6.h,
                      ),
                    ),
                    SizedBox(width: 2.w),
                  ],
                ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'not_processed'.tr,
                          style: const TextStyle(
                            color: AppColors.primary40,
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                    if (isLandlord)
                      Text(
                        'data',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'sent_time'.tr,
                          style: const TextStyle(
                            color: AppColors.secondary20,
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          ),
                        ),
                        const Text(' '),
                        const Text(
                          '8:30 04/12/2023',
                          style: TextStyle(
                            color: AppColors.secondary20,
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                color: AppColors.primary40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
