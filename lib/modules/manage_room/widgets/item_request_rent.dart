import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/core/values/image_assets.dart';
import 'package:smart_rent/core/widget/cache_image_widget.dart';
import 'package:smart_rent/modules/manage_room/views/widgets/status_request_rent.dart';

class ItemRequestRent extends StatelessWidget {
  final VoidCallback onNav;

  const ItemRequestRent({super.key, required this.onNav});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 1, color: AppColors.primary95),
        borderRadius: BorderRadius.circular(16.px),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          _buildSumQuantity(),
          SizedBox(height: 1.2.h),
          _buildDescription(),
          SizedBox(height: 1.2.h),
          ...[
            StatusRequestRent(
              sumQuantityRequest: 2,
              onTap: onNav,
              isLandlord: true,
            ),
          ],
        ],
      ),
    );
  }

  Container _buildDescription() {
    return Container(
      padding: EdgeInsets.all(8.px),
      margin: EdgeInsets.symmetric(horizontal: 16.px),
      decoration: BoxDecoration(
        color: AppColors.primary98,
        borderRadius: BorderRadius.circular(10.px),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.px),
            child: CacheImageWidget(
              imageUrl: ImageAssets.demo,
              width: 6.h,
              height: 6.h,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            width: 2.w,
          ),
          const Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'HOMESTAY DOOM MẶT TIỀN HÀNG...',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: AppColors.secondary20,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        '1.6 triệu VND/người',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary40,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Khối 5, thị trấn Đức Thọ',
                        style: TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.w400,
                          color: AppColors.secondary20,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  RichText _buildSumQuantity() {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: 'you_have_sent'.tr,
            style: const TextStyle(
              color: AppColors.secondary20,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const TextSpan(
            text: ' 2 ',
            style: TextStyle(
              color: AppColors.secondary20,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          TextSpan(
            text: 'rental_request'.tr.toLowerCase(),
            style: const TextStyle(
              color: AppColors.primary40,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const TextSpan(text: ' '),
          TextSpan(
            text: 'rent_room'.tr,
            style: const TextStyle(
              color: AppColors.secondary20,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
