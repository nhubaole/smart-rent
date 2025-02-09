import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/core/enums/loading_type.dart';
import 'package:smart_rent/core/extension/double_extension.dart';
import 'package:smart_rent/core/extension/int_extension.dart';
import 'package:smart_rent/core/model/room/room_model.dart';
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

  Widget _buildListRooms() {
    return SizedBox(
      height: 290.px,
      child: Column(
        mainAxisSize: MainAxisSize.min,
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
          Expanded(
            child: Container(
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                padding:
                    EdgeInsets.symmetric(horizontal: 16.px, vertical: 16.px),
                child: ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final item = controller.userModel.value.rooms![index];
                      return RoomItemUserPage(item: item);
                    },
                    separatorBuilder: (context, index) => SizedBox(width: 8.px),
                    itemCount: controller.userModel.value.rooms!.length),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListRatingInfo() {
    return SizedBox(
      height: 300.px,
      child: Column(
        mainAxisSize: MainAxisSize.min,
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
          Expanded(
            child: Container(
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                padding:
                    EdgeInsets.symmetric(horizontal: 16.px, vertical: 16.px),
                child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final item = controller.userModel.value.ratingInfos![index];
                    return RatingItemWithoutImgWidget(
                      avatarUser: controller.userModel.value.avatarUrl ??
                          ImageAssets.demo,
                      ratingInfo: item,
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(width: 8.px),
                  itemCount:
                      controller.userModel.value.ratingInfos?.length ?? 0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container _buildAvatarAndRatingInfo() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.px),
      padding: EdgeInsets.all(16.px),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.px),
        border: Border.all(
          color: AppColors.secondary90,
          width: 1.px,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.secondary60.withOpacity(0.6),
            blurRadius: 2.px,
            offset: Offset(-1.px, 1.px),
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
            fontSize: 22.sp,
          ),
        ),
        SizedBox(height: 4.px),
        Text(
          controller.userModel.value.role == 1 ? 'Chủ nhà' : 'Người thuê',
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

class RoomItemUserPage extends StatelessWidget {
  const RoomItemUserPage({
    super.key,
    required this.item,
  });

  final RoomModel item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.px),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.px),
        border: Border.all(
          color: AppColors.secondary80.withOpacity(0.2),
          width: 1.px,
        ),
      ),
      width: Get.width * 0.4,
      height: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: _buildImage(),
          ),
          SizedBox(height: 8.px),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildRating(),
                SizedBox(height: 2.px),
                _buildTitle(),
                SizedBox(height: 2.px),
                _buildPrice(),
                SizedBox(height: 2.px),
                _buildAddress()
              ],
            ),
          ),
        ],
      ),
    );
  }

  Text _buildAddress() {
    return Text(
      item.address ?? item.addresses?.join(', ') ?? '--',
      textAlign: TextAlign.start,
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
      style: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.secondary40,
      ),
    );
  }

  RichText _buildPrice() {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: 'Giá chỉ từ: ',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.primary40,
            ),
          ),
          TextSpan(
            text: item.totalPrice?.toStringTotalthis() ?? '',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.primary40,
            ),
          ),
        ],
      ),
    );
  }

  Text _buildTitle() {
    return Text(
      item.title!,
      textAlign: TextAlign.start,
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
      style: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.secondary20,
      ),
    );
  }

  Row _buildRating() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 4.px, vertical: 2.px),
          decoration: BoxDecoration(
            color: AppColors.primary40,
            borderRadius: BorderRadius.circular(4.px),
          ),
          child: Row(
            children: [
              Text(item.avgRating?.toString() ?? '0.0',
                  style: TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 13.sp,
                  )),
              SizedBox(width: 2.px),
              Icon(
                Icons.star_sharp,
                color: AppColors.rating,
                size: 16.px,
              ),
            ],
          ),
        ),
        Text(
            item.avgRating != null
                ? item.avgRating!.toInt().toStringRatingType
                : '',
            style: TextStyle(
              color: AppColors.white,
              fontWeight: FontWeight.bold,
              fontSize: 13.sp,
            )),
        SizedBox(width: 2.px),
        Text.rich(
          TextSpan(children: [
            TextSpan(
                text: item.totalRating?.toString() ?? '0',
                style: TextStyle(
                    fontSize: 12,
                    color: AppColors.secondary40,
                    fontWeight: FontWeight.w600)),
            TextSpan(text: ' '),
            TextSpan(
              text: 'đánh giá',
              style: TextStyle(
                  fontSize: 12,
                  color: AppColors.secondary40,
                  fontWeight: FontWeight.w600),
            )
          ]),
        ),
      ],
    );
  }

  ClipRRect _buildImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.px),
      child: CacheImageWidget(
        width: double.infinity,
        height: 100.px,
        imageUrl: item.images![0],
      ),
    );
  }
}
