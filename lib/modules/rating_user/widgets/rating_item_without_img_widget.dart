import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/core/helper/helper.dart';
import 'package:smart_rent/core/model/user/user_model.dart';
import 'package:smart_rent/core/widget/cache_image_widget.dart';

class RatingItemWithoutImgWidget extends StatelessWidget {
  final RatingInfo ratingInfo;
  final String avatarUser;
  const RatingItemWithoutImgWidget({
    super.key,
    required this.ratingInfo,
    required this.avatarUser,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.8,
      padding: EdgeInsets.all(16.px),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.px),
        border: Border.all(
          color: AppColors.secondary80.withOpacity(0.5),
          width: 1.px,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.secondary60.withOpacity(0.5),
            blurRadius: 2.px,
            offset: Offset(0, 1.px),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildUserInfo(),
          SizedBox(height: 16.px),
          Text.rich(
            style: TextStyle(
              color: AppColors.secondary40,
              fontWeight: FontWeight.w500,
              fontSize: 16.sp,
            ),
            TextSpan(
              text: ratingInfo.comment ?? '',
            ),
          ),
          SizedBox(height: 16.px),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                FontAwesomeIcons.faceSmile,
                color: AppColors.secondary40,
                size: 24.px,
              ),
              SizedBox(width: 4.px),
              Expanded(
                child: Text.rich(
                  style: TextStyle(
                    color: AppColors.secondary40,
                    fontWeight: FontWeight.w400,
                    fontSize: 16.sp,
                  ),
                  TextSpan(text: ratingInfo.happy ?? ''),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.px),
          Row(
            children: [
              Icon(
                FontAwesomeIcons.faceAngry,
                color: AppColors.secondary40,
                size: 24.px,
              ),
              SizedBox(width: 4.px),
              Expanded(
                child: Text.rich(
                  style: TextStyle(
                    color: AppColors.secondary40,
                    fontWeight: FontWeight.w400,
                    fontSize: 16.sp,
                  ),
                  TextSpan(
                    text: ratingInfo.unHappy ?? '',
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Row _buildUserInfo() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipOval(
          child: CacheImageWidget(
            width: 48.px,
            height: 48.px,
            imageUrl: avatarUser,
          ),
        ),
        SizedBox(width: 8.px),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(
                style: TextStyle(
                  color: AppColors.secondary20,
                  fontWeight: FontWeight.w600,
                  fontSize: 16.sp,
                ),
                TextSpan(text: ratingInfo.ratingName ?? ''),
              ),
              SizedBox(height: 4.px),
              Text(
                Helper.timeAgo(
                  ratingInfo.createAt ?? DateTime.now(),
                ),
                style: TextStyle(
                  color: AppColors.secondary60,
                  fontWeight: FontWeight.w400,
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: List.generate(
            ratingInfo.rate ?? 0,
            (index) => Icon(
              Icons.star,
              color: AppColors.rating,
              size: 18.px,
            ),
          ),
        ),
      ],
    );
  }
}
