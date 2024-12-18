import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/core/helper/helper.dart';
import 'package:smart_rent/core/model/rating/rating_info_model.dart';
import 'package:smart_rent/core/values/image_assets.dart';
import 'package:smart_rent/core/widget/cache_image_widget.dart';

class RatingItemWidget extends StatelessWidget {
  final RatingInfoModel ratingInfo;
  final Function() onTapNavUser;
  const RatingItemWidget({
    super.key,
    required this.ratingInfo,
    required this.onTapNavUser,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.px),
        boxShadow: [
          BoxShadow(
            color: AppColors.secondary60.withOpacity(0.5),
            blurRadius: 2.px,
            offset: Offset(0, 1.px),
          ),
        ],
      ),
      child: Material(
        color: AppColors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12.px),
          onTap: onTapNavUser,
          child: Container(
            padding: EdgeInsets.all(16.px),
            
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
                if (ratingInfo.images?.isNotEmpty ?? false) _buildImages(),
                SizedBox(height: 16.px),
                Row(
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
                        TextSpan(text: ratingInfo.unHappy ?? ''),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column _buildImages() {
    return Column(
      children: [
        SizedBox(height: 16.px),
        SizedBox(
          height: 100.px,
          child: ListView.separated(
            separatorBuilder: (context, index) => SizedBox(
              width: 4.px,
            ),
            itemCount: ratingInfo.images?.length ?? 0,
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final imageUrl = ratingInfo.images![index];
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.px),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.secondary60.withOpacity(0.3),
                      blurRadius: 1.px,
                      offset: Offset(0, 1.px),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.px),
                  child: CacheImageWidget(
                    height: 100.px,
                    width: 100.px,
                    imageUrl: imageUrl,
                  ),
                ),
              );
            },
          ),
        ),
      ],
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
            imageUrl: ratingInfo.raterAvatar ?? ImageAssets.demo,
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
                TextSpan(text: ratingInfo.raterName ?? ''),
              ),
              SizedBox(height: 4.px),
              Text(
                Helper.timeAgo(
                  ratingInfo.createdAt ?? DateTime.now(),
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
