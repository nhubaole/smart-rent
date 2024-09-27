import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/config/app_colors.dart';
import '/core/values/app_colors.dart';
import '/core/values/image_assets.dart';
import '/core/widget/custom_app_bar.dart';

import '../../widgets/status_request_rent.dart';
import 'detail_request_rent_room_v2.dart';

class RequestRentV2Screen extends StatelessWidget {
  const RequestRentV2Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Yêu cầu thuê trọ',
      ),
      body: Container(
        padding: const EdgeInsets.only(
          top: 20,
          left: 20,
          right: 20,
          bottom: 50,
        ),
        child: ListView.separated(
          separatorBuilder: (context, index) => const SizedBox(
            height: 20,
          ),
          itemCount: 10,
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.only(top: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 1, color: AppColors.primary95),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  _buildSumQuantity(),
                  const SizedBox(
                    height: 12,
                  ),
                  _buildDescription(),
                  const SizedBox(
                    height: 12,
                  ),
                  ...[
                    StatusRequestRent(
                      sumQuantityRequest: 2,
                      onTap: () {
                        Get.to(() => const DetailRequestRentRoomV2());
                      },
                    ),
                  ],
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Container _buildDescription() {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.primary98,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              imageUrl: ImageAssets.demo,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            width: 10,
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
      text: const TextSpan(
        children: [
          TextSpan(
            text: 'Bạn đã gửi ',
            style: TextStyle(
              color: AppColors.secondary20,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          TextSpan(
            text: '2 yêu cầu thuê trọ ',
            style: TextStyle(
              color: AppColors.primary40,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          TextSpan(
            text: 'thuê phòng trọ: ',
            style: TextStyle(
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
