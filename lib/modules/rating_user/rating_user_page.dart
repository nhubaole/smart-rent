import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/core/enums/loading_type.dart';
import 'package:smart_rent/core/values/image_assets.dart';
import 'package:smart_rent/core/widget/cache_image_widget.dart';
import 'package:smart_rent/core/widget/custom_app_bar.dart';
import 'package:smart_rent/core/widget/error_widget.dart';
import 'package:smart_rent/core/widget/loading_widget.dart';
import 'package:smart_rent/core/widget/room_item.dart';
import 'package:smart_rent/core/widget/scaffold_widget.dart';
import 'package:smart_rent/modules/rating_user/rating_user_controller.dart';
import 'package:smart_rent/modules/rating_user/widgets/rating_item_without_img_widget.dart';

class RatingUserPage extends GetView<RatingUserController> {
  const RatingUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      appBar: CustomAppBar(title: 'Trang cá nhân'),
      body: Obx(() => _buildWidgetByStatus()),
    );
  }

  Widget _buildWidgetByStatus() {
    switch (controller.isLoading.value) {
      case LoadingType.INIT:
      case LoadingType.LOADING:
        return LoadingWidget();
      case LoadingType.LOADED:
        return _buildInfo();
      case LoadingType.ERROR:
        return ErrorCustomWidget();
    }
  }

  Widget _buildInfo() {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(vertical: 16.px),
      child: Column(
        children: [
          _buildAvatarAndRatingInfo(),
          SizedBox(height: 16.px),
          if (controller.userModel.value.ratingInfos?.isNotEmpty ?? false)
            _buildListRatingInfo(),
          SizedBox(height: 16.px),
          if (controller.userModel.value.rooms?.isNotEmpty ?? false)
            _buildListRooms(),
          SizedBox(height: 16.px),
          _buildVerified(),
          SizedBox(height: 16.px),
        ],
      ),
    );
  }

  Container _buildVerified() {
    final colorVerified = AppColors.green20;
    final colorUnverified = AppColors.red40;
    final textStyle = TextStyle(
      color: AppColors.secondary20,
      fontWeight: FontWeight.w500,
      fontSize: 16.sp,
    );

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.px),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'Thông tin đã xác thực',
              style: TextStyle(
                color: AppColors.secondary20,
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
              ),
            ),
          ),
          SizedBox(height: 16.px),
          Row(
            children: [
              controller.isVerifiedID
                  ? Icon(
                      FontAwesomeIcons.check,
                      color: colorVerified,
                    )
                  : Icon(
                      FontAwesomeIcons.ban,
                      color: colorUnverified,
                    ),
              SizedBox(width: 8.px),
              Text(
                'Danh tính',
                style: textStyle.copyWith(
                  color:
                      controller.isVerifiedID ? colorVerified : colorUnverified,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.px),
          Row(
            children: [
              controller.isVerifiedPhone
                  ? Icon(
                      FontAwesomeIcons.check,
                      color: colorVerified,
                    )
                  : Icon(
                      FontAwesomeIcons.ban,
                      color: colorUnverified,
                    ),
              SizedBox(width: 8.px),
              Text(
                'Số điện thoại',
                style: textStyle.copyWith(
                  color: controller.isVerifiedPhone
                      ? colorVerified
                      : colorUnverified,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Column _buildListRooms() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16.px),
          alignment: Alignment.centerLeft,
          child: Text(
            'Danh sách phòng trọ',
            style: TextStyle(
              color: AppColors.secondary20,
              fontWeight: FontWeight.bold,
              fontSize: 16.sp,
            ),
          ),
        ),
        Container(
          alignment: Alignment.topCenter,
          height: 300.px,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16.px, vertical: 16.px),
            child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final item = controller.userModel.value.rooms![index];
                return RoomItem(
                  room: item,
                );
              },
              separatorBuilder: (context, index) => SizedBox(width: 8.px),
              itemCount: controller.userModel.value.ratingInfos?.length ?? 0,
            ),
          ),
        ),
      ],
    );
  }

  Column _buildListRatingInfo() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16.px),
          alignment: Alignment.centerLeft,
          child: Text(
            'Bài đánh giá chủ nhà',
            style: TextStyle(
              color: AppColors.secondary20,
              fontWeight: FontWeight.bold,
              fontSize: 16.sp,
            ),
          ),
        ),
        Container(
          alignment: Alignment.topCenter,
          height: Get.height / 3,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16.px, vertical: 16.px),
            child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final item = controller.userModel.value.ratingInfos![index];
                return RatingItemWithoutImgWidget(
                  avatarUser:
                      controller.userModel.value.avatarUrl ?? ImageAssets.demo,
                  ratingInfo: item,
                );
              },
              separatorBuilder: (context, index) => SizedBox(width: 8.px),
              itemCount: controller.userModel.value.ratingInfos?.length ?? 0,
            ),
          ),
        ),
      ],
    );
  }

  Container _buildAvatarAndRatingInfo() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.px),
      padding: EdgeInsets.all(16.px),
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
      child: Row(
        children: [
          Expanded(
            child: _buildInfoUser(),
          ),
          Expanded(
            child: _buildInfoRating(),
          ),
        ],
      ),
    );
  }

  Column _buildInfoRating() {
    final style = TextStyle(
      color: AppColors.secondary20,
      fontWeight: FontWeight.bold,
      fontSize: 20.sp,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          controller.userModel.value.totalRating?.toString() ?? '0',
          style: style,
        ),
        Text(
          'Đánh giá',
          style: style.copyWith(fontSize: 16.sp),
        ),
        SizedBox(height: 8.px),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              controller.userModel.value.avgRating?.toString() ?? '0',
              style: style,
            ),
            Icon(
              Icons.star,
              color: AppColors.secondary20,
              size: 24.px,
            ),
          ],
        ),
        Text(
          'Xếp hạng',
          style: style.copyWith(fontSize: 16.sp),
        ),
        SizedBox(height: 8.px),
        Text(
          controller.userModel.value.totalRoom?.toString() ?? '0',
          style: style,
        ),
        Text(
          'Phòng trọ',
          style: style.copyWith(fontSize: 16.sp),
        ),
      ],
    );
  }

  Column _buildInfoUser() {
    return Column(
      children: [
        ClipOval(
          child: CacheImageWidget(
            width: 85.px,
            height: 85.px,
            imageUrl: controller.userModel.value.avatarUrl ?? ImageAssets.demo,
          ),
        ),
        SizedBox(height: 4.px),
        Text(
          controller.userModel.value.fullName ?? '',
          style: TextStyle(
            color: AppColors.primary40,
            fontWeight: FontWeight.bold,
            fontSize: 24.sp,
          ),
        ),
        SizedBox(height: 4.px),
        Text(
          controller.userModel.value.role == 0 ? 'Chủ nhà' : 'Người thuê',
          style: TextStyle(
            color: AppColors.secondary20,
            fontWeight: FontWeight.bold,
            fontSize: 16.sp,
          ),
        ),
      ],
    );
  }
}
