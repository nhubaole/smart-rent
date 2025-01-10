import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/core/enums/request_room_status.dart';
import 'package:smart_rent/core/extension/datetime_extension.dart';
import 'package:smart_rent/core/extension/double_extension.dart';
import 'package:smart_rent/core/extension/int_extension.dart';
import 'package:smart_rent/core/values/image_assets.dart';
import 'package:smart_rent/core/widget/button_outline.dart';
import 'package:smart_rent/core/widget/cache_image_widget.dart';
import 'package:smart_rent/core/widget/outline_button_widget.dart';
import 'package:smart_rent/core/widget/scaffold_widget.dart';
import 'package:smart_rent/modules/manage_room/controllers/sub_screen_controller/detail_request_controller.dart';
import '/core/widget/custom_app_bar.dart';

class DetailRequestRentRoomV2 extends GetView<DetailRequestController> {
  const DetailRequestRentRoomV2({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      appBar: const CustomAppBar(
        title: 'Thông tin yêu cầu',
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Column(
            children: [
              SizedBox(height: 2.h),
              _buildStatus(),
              if (controller.isLandlord &&
                  controller.requestStatus == RequestRoomStatus.accepted)
                _buildDraftContract(),
              SizedBox(height: 2.h),
              _buildInfoRoom(),
              SizedBox(height: 2.h),
              _buildTimeSend(),
              if (!controller.isLandlord &&
                  (controller.requestStatus != RequestRoomStatus.accepted &&
                      controller.requestStatus != RequestRoomStatus.rejected &&
                      controller.requestStatus != RequestRoomStatus.canceled))
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 2.h),
                    _buildButtonActionForTenant(),
                  ],
                ),
              SizedBox(height: 2.h),
              _buildContact(),
              SizedBox(height: 2.h),
              _buildInfo(),
              SizedBox(height: 3.h),
              if (controller.isLandlord &&
                  (controller.requestStatus != RequestRoomStatus.accepted &&
                      controller.requestStatus != RequestRoomStatus.rejected &&
                      controller.requestStatus != RequestRoomStatus.canceled))
                _buildButtonActionForLandlord(),
              SizedBox(height: 3.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDraftContract() {
    return OutlineButtonWidget(
      padding: EdgeInsets.zero,
      height: 40.px,
      margin: EdgeInsets.only(top: 16.px),
      text: 'draft_contract'.tr,
      onTap: controller.onNavLandlordContractCreate,
      leading: const Icon(
        Icons.edit_note_outlined,
        size: 20,
        color: AppColors.primary60,
      ),
    );
    return Column(
      children: [
        SizedBox(height: 2.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.px),
          child: Row(
            children: [
              Expanded(
                child: ButtonOutline(
                  borderWidth: 1.5,
                  onPressed: controller.onNavLandlordContractCreate,
                  icon: const Icon(
                    Icons.edit_note_outlined,
                    size: 20,
                    color: AppColors.primary60,
                  ),
                  text: Text(
                    'draft_contract'.tr,
                    style: const TextStyle(
                      color: AppColors.primary60,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  borderColor: AppColors.primary60,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Row _buildButtonActionForTenant() {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.error.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10.px),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(10.px),
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.px,
                    vertical: 8.px,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const Icon(
                        Icons.delete,
                        color: AppColors.error,
                      ),
                      Text(
                        'cancel_request'.tr,
                        style: const TextStyle(
                          color: AppColors.error,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 5.w,
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.secondary90,
              borderRadius: BorderRadius.circular(10.px),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(10.px),
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.px,
                    vertical: 8.px,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const Icon(
                        Icons.edit,
                        color: AppColors.secondary40,
                      ),
                      SizedBox(width: 3.px),
                      Text(
                        'edit'.tr,
                        style: const TextStyle(
                          color: AppColors.secondary40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row _buildButtonActionForLandlord() {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.error.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10.px),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(10.px),
                onTap: controller.onRejectRequest,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.px,
                    vertical: 8.px,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.close,
                        color: AppColors.error,
                      ),
                      Text(
                        'reject'.tr,
                        style: const TextStyle(
                          color: AppColors.error,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 5.w,
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.greenOrigin.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10.px),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(10.px),
                onTap: controller.onApproveRequest,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.px,
                    vertical: 8.px,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.check,
                        color: AppColors.greenOrigin,
                      ),
                      Text(
                        'accept'.tr,
                        style: const TextStyle(
                          color: AppColors.greenOrigin,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Column _buildInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildPriceOffer(),
        SizedBox(height: 16.px),
        _buildQuantiyRoomates(),
        SizedBox(height: 16.px),
        _buildStartDate(),
        SizedBox(height: 16.px),
        _buildEndDate(),
        SizedBox(height: 16.px),
        _buildSpecialRequest(),
      ],
    );
  }

  Column _buildSpecialRequest() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'special_request'.tr,
          style: TextStyle(
            fontSize: 17.sp,
            color: AppColors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 5.px),
        Text.rich(
          style: TextStyle(
            fontSize: 16.sp,
            color: AppColors.secondary40,
            fontWeight: FontWeight.w400,
          ),
          TextSpan(
            text: controller.rentalRequest.additionRequest ?? '--',
          ),
        ),
      ],
    );
  }

  Column _buildEndDate() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'rental_end_date'.tr,
          style: TextStyle(
            fontSize: 17.sp,
            color: AppColors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 5.px),
        Row(
          children: [
            const Icon(
              Icons.date_range,
              color: AppColors.secondary40,
            ),
            SizedBox(width: 5.px),
            Text(
              controller.rentalRequest.endDate?.ddMMyyyy ?? 'Dài hạn',
              style: TextStyle(
                fontSize: 16.sp,
                color: AppColors.secondary40,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Column _buildStartDate() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'rental_start_date'.tr,
          style: TextStyle(
            fontSize: 17.sp,
            color: AppColors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 5.px),
        Row(
          children: [
            const Icon(
              Icons.date_range,
              color: AppColors.secondary40,
            ),
            SizedBox(width: 5.px),
            Text(
              controller.rentalRequest.beginDate?.ddMMyyyy ?? '--',
              style: TextStyle(
                fontSize: 16.sp,
                color: AppColors.secondary40,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Column _buildQuantiyRoomates() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'expected_number_of_roommates'.tr,
          style: TextStyle(
            fontSize: 17.sp,
            color: AppColors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 5.px),
        Text.rich(
          style: TextStyle(
            fontSize: 16.sp,
            color: AppColors.secondary40,
            fontWeight: FontWeight.w400,
          ),
          TextSpan(
            children: [
              TextSpan(
                text: '${controller.rentalRequest.numOfPerson ?? '0'} ',
              ),
              const TextSpan(
                text: ' người',
              ),
            ],
          ),
        ),
        SizedBox(height: 5.px),
        controller.rentalRequest.numOfPerson != null &&
                controller.rentalRequest.numOfPerson! <=
                    controller.rentalRequest.room!.capacity!
            ? Row(
                children: [
                  const Icon(
                    Icons.check,
                    color: AppColors.greenOrigin,
                  ),
                  SizedBox(width: 3.px),
                  Text(
                    'suitable_for_room_capacity'.tr,
                    style: const TextStyle(
                      color: AppColors.greenOrigin,
                    ),
                  ),
                ],
              )
            : Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Icon(
                    Icons.close,
                    color: AppColors.error,
                  ),
                  SizedBox(width: 3.px),
                  Expanded(
                    child: Text.rich(
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: AppColors.error,
                        fontWeight: FontWeight.w400,
                      ),
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Không phù hợp với sức chứa phòng trọ '.tr,
                          ),
                          TextSpan(
                            text:
                                'quá ${controller.rentalRequest.numOfPerson! - controller.rentalRequest.room!.capacity!} người',
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ],
    );
  }

  Column _buildPriceOffer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'price_offer'.tr,
          style: TextStyle(
            fontSize: 17.sp,
            color: AppColors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 5.px),
        Text(
          controller.rentalRequest.suggestedPrice?.toStringTotalthis() ?? '--',
          style: TextStyle(
            fontSize: 16.sp,
            color: AppColors.black,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(
          height: 5.px,
        ),
        Row(
          children: [
            controller.rentalRequest.suggestedPrice != null &&
                    controller.rentalRequest.suggestedPrice! >
                        controller.rentalRequest.room!.totalPrice!
                ? const Icon(
                    Icons.arrow_upward,
                    color: AppColors.greenOrigin,
                  )
                : const Icon(
                    Icons.arrow_downward,
                    color: AppColors.error,
                  ),
            SizedBox(width: 3.px),
            controller.rentalRequest.suggestedPrice != null &&
                    controller.rentalRequest.suggestedPrice! >
                        controller.rentalRequest.room!.totalPrice!
                ? Text.rich(
                    TextSpan(
                      style: const TextStyle(
                        color: AppColors.greenOrigin,
                      ),
                      children: [
                        TextSpan(
                          text: 'higher_origin_price'.tr,
                        ),
                        const TextSpan(
                          text: ' ',
                        ),
                        TextSpan(
                          text: (controller.rentalRequest.suggestedPrice! -
                                  controller.rentalRequest.room!.totalPrice!)
                              .toStringTotalthis(),
                        ),
                      ],
                    ),
                  )
                : Text.rich(
                    TextSpan(
                      style: const TextStyle(
                        color: AppColors.error,
                      ),
                      children: [
                        TextSpan(
                          text: 'lower_origin_price'.tr,
                        ),
                        const TextSpan(
                          text: ' ',
                        ),
                        TextSpan(
                          text: (controller.rentalRequest.room!.totalPrice! -
                                  controller.rentalRequest.suggestedPrice!)
                              .toStringTotalthis(),
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      ],
    );
  }

  Container _buildContact() {
    final TextStyle textStyle = TextStyle(
      fontSize: 16.sp,
      color: AppColors.white,
      fontWeight: FontWeight.bold,
    );
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: 16.px,
        horizontal: 16.px,
      ),
      decoration: BoxDecoration(
        color: AppColors.primary40,
        borderRadius: BorderRadius.circular(10.px),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Flexible(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  controller.rentalRequest.sender?.fullName ?? '--',
                  style: textStyle.copyWith(
                    fontSize: 22.px,
                  ),
                ),
                SizedBox(height: 12.px),
                Row(
                  children: [
                    const Icon(
                      Icons.phone,
                      color: AppColors.white,
                    ),
                    SizedBox(width: 12.px),
                    Text(
                      controller.rentalRequest.sender?.phoneNumber ?? '--',
                      style: textStyle.copyWith(
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          ClipOval(
            child: Container(
              height: 70.px,
              width: 70.px,
              color: AppColors.grey20,
              child: CacheImageWidget(
                imageUrl: controller.rentalRequest.sender?.avatarUrl ??
                    ImageAssets.demo,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Row _buildTimeSend() {
    final TextStyle textStyleLeft = TextStyle(
      fontSize: 17.sp,
      color: AppColors.secondary20,
      fontWeight: FontWeight.w600,
    );
    final TextStyle textStyleRight = TextStyle(
      fontSize: 16.sp,
      color: AppColors.secondary40,
      fontWeight: FontWeight.w400,
    );
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text.rich(
          TextSpan(
            style: textStyleLeft,
            children: [
              TextSpan(text: 'request'.tr),
              const TextSpan(text: ' #'),
              TextSpan(
                text: controller.rentalRequest.id.toString(),
              ),
            ],
          ),
        ),
        Row(
          children: [
            const Icon(
              Icons.timer_outlined,
              color: AppColors.secondary40,
            ),
            Text.rich(
              style: textStyleRight,
              TextSpan(
                children: [
                  TextSpan(
                    text: controller.rentalRequest.createdAt?.hhmmDDMMyyyy,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Row _buildInfoRoom() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Flexible(
          child: CacheImageWidget(
            imageUrl: ImageAssets.demo,
            borderRadius: BorderRadius.circular(20.px),
            height: 120.px,
            width: 120.px,
          ),
        ),
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                'number_of_people'.tr,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.grey20,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                controller.rentalRequest.room!.title ?? '',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                controller.rentalRequest.room!.addresses?.join(', ') ?? '',
                style: TextStyle(
                  color: AppColors.secondary20,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.normal,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                controller.rentalRequest.room!.totalPrice!.toStringTotalthis(),
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary40,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatus() {
    final status = RequestRoomStatusExtension.fromInt(
      controller.rentalRequest.status ?? 0,
    );
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: 1.h,
        horizontal: 2.h,
      ),
      decoration: BoxDecoration(
        color: status.colorBackground,
        borderRadius: BorderRadius.circular(8.px),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(status.icon, color: status.colorContent),
          SizedBox(width: 1.w),
          Text(
            status.value,
            style: TextStyle(
              color: status.colorContent,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
