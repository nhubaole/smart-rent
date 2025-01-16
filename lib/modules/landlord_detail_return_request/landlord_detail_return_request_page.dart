import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/core/enums/loading_type.dart';
import 'package:smart_rent/core/enums/request_room_status.dart';
import 'package:smart_rent/core/extension/datetime_extension.dart';
import 'package:smart_rent/core/extension/double_extension.dart';
import 'package:smart_rent/core/values/image_assets.dart';
import 'package:smart_rent/core/widget/button_outline.dart';
import 'package:smart_rent/core/widget/cache_image_widget.dart';
import 'package:smart_rent/core/widget/custom_app_bar.dart';
import 'package:smart_rent/core/widget/error_widget.dart';
import 'package:smart_rent/core/widget/loading_widget.dart';
import 'package:smart_rent/core/widget/scaffold_widget.dart';
import 'package:smart_rent/core/widget/solid_button_widget.dart';
import 'package:smart_rent/modules/landlord_detail_return_request/landlord_detail_return_request_controller.dart';

class LandlordDetailReturnRequestPage
    extends GetView<LandlordDetailReturnRequestController> {
  const LandlordDetailReturnRequestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      appBar: const CustomAppBar(
        title: 'Thông tin yêu cầu',
      ),
      body: Obx(() => _buildWidgetStatus()),
    );
  }

  Widget _buildWidgetStatus() {
    switch (controller.isLoadingType.value) {
      case LoadingType.INIT:
      case LoadingType.LOADING:
        return LoadingWidget();
      case LoadingType.LOADED:
        return _buildContent();
      case LoadingType.ERROR:
        return RefreshIndicator(
          onRefresh: () async => controller.fetchData(),
          child: ErrorCustomWidget(
            expandToCanPullToRefresh: true,
          ),
        );
    }
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: Column(
          children: [
            SizedBox(height: 2.h),
            _buildStatus(),
            SizedBox(height: 2.h),
            _buildReopenForRent(),
            SizedBox(height: 2.h),
            _buildInfoRoom(),
            SizedBox(height: 2.h),
            _buildIdAndCreateTime(),
            SizedBox(height: 2.h),
            _buildContact(),
            SizedBox(height: 2.h),
            _buildInfo(),
            SizedBox(height: 3.h),
            _buildButtonSubmit(),
            SizedBox(height: 3.h),
          ],
        ),
      ),
    );
  }

  Widget _buildButtonSubmit() {
    if (controller.returnRequestByIdModel?.status == 0) {
      return SolidButtonWidget(
        text: 'Xác nhận',
        onTap: controller.onConfirm,
      );
    } else if (controller.returnRequestByIdModel?.status == 1) {
      return SolidButtonWidget(
        text: 'Xác nhận',
        onTap: controller.onConfirm,
      );
    } else if (controller.returnRequestByIdModel?.status == 2) {
      return Container();
    } else {
      return Container();
    }
  }

  Row _buildIdAndCreateTime() {
    final TextStyle textStyle = TextStyle(
      fontSize: 16.sp,
      color: AppColors.secondary40,
      fontWeight: FontWeight.w400,
    );
    return Row(
      children: [
        Expanded(
          child: Text(
            'Yêu cầu #${controller.returnRequestByIdModel?.id}',
            textAlign: TextAlign.start,
            style: textStyle.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.secondary20,
            ),
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(FontAwesomeIcons.clock, size: 16.sp),
              SizedBox(width: 5.px),
              Text(
                '${controller.returnRequestByIdModel!.returnDate?.hhmmDDMMyyyy}',
                textAlign: TextAlign.end,
                style: textStyle,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Column _buildReopenForRent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            style: TextStyle(
              fontSize: 16.sp,
              color: AppColors.secondary40,
              fontWeight: FontWeight.w400,
            ),
            children: [
              TextSpan(text: 'Bạn có muốn cập nhật trạng thái phòng trọ thành'),
              TextSpan(
                text: ' sắp trống ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(text: 'để tìm khách thuê mới?'),
            ],
          ),
        ),
        SizedBox(height: 2.h),
        InkWell(
          borderRadius: BorderRadius.circular(10.px),
          onTap: () {},
          child: Container(
            padding: EdgeInsets.all(8.px),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text.rich(
                textAlign: TextAlign.start,
                TextSpan(
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: AppColors.primary60,
                    fontWeight: FontWeight.w600,
                  ),
                  text:
                      'Mở tin cho thuê - Dọn vào từ ${controller.returnRequestByIdModel?.returnDate?.ddMMyyyy ?? ''}',
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Column _buildDraftContract() {
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
                  onPressed: () {},
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
                onTap: () {},
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
                onTap: () {},
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
        _buildReturnDate(),
        SizedBox(height: 16.px),
        _buildReason(),
        SizedBox(height: 16.px),
        _buildInfoReturnDeposit(),
        Divider(
          color: AppColors.secondary80.withOpacity(0.5),
          thickness: 1,
          height: 16.px,
        ),
        Text.rich(
          style: TextStyle(
            fontSize: 15.sp,
            color: AppColors.secondary40,
            fontWeight: FontWeight.w500,
          ),
          TextSpan(
            text:
                'Bạn có 7 ngày kể từ ngày người thuê trả phòng để kiểm tra và xác nhận tình trạng phòng cũng như ghi nhận hư hại (nếu có). Sau thời gian này, hệ thống sẽ tự động xác nhận việc trả phòng đã hoàn tất.',
          ),
        ),
      ],
    );
  }

  Widget _buildInfoReturnDeposit() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Thông tin hoàn trả tiền cọc'.tr,
          style: TextStyle(
            fontSize: 17.sp,
            color: AppColors.secondary20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8.px),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.px),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(10.px),
            border: Border.all(
              color: AppColors.secondary60,
              width: 0.5.px,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.secondary90,
                blurRadius: 1.px,
                offset: Offset(0, 2.px),
              ),
            ],
          ),
          child: Column(
            children: [
              _buildItemRow(
                key: 'Tiền đặt cọc'.tr,
                value: controller.returnRequestByIdModel?.totalReturnDeposit!
                        .toStringTotalthis(symbol: 'đ') ??
                    '--',
              ),
              Divider(
                color: AppColors.secondary80.withOpacity(0.5),
                thickness: 1,
                height: 16.px,
              ),
              _buildItemRow(
                key: 'Tiền cấn trừ'.tr,
                value: controller.returnRequestByIdModel?.deductAmount!
                        .toStringTotalthis(symbol: 'đ') ??
                    '--',
              ),
              Divider(
                color: AppColors.secondary80.withOpacity(0.5),
                thickness: 1,
                height: 16.px,
              ),
              _buildItemRow(
                key: 'Lý do'.tr,
                value: 'Vi phạm thời hạn thông báo trả phòng',
              ),
              Divider(
                color: AppColors.secondary80.withOpacity(0.5),
                thickness: 1,
                height: 16.px,
              ),
              _buildItemRow(
                key: 'Người nhận'.tr,
                value:
                    'Bên B\n${controller.returnRequestByIdModel?.createdUser?.fullName ?? '--'}',
              ),
              Divider(
                color: AppColors.secondary80.withOpacity(0.5),
                thickness: 1,
                height: 16.px,
              ),
            ],
          ),
        ),
        SizedBox(height: 8.px),
        Row(
          children: [
            Expanded(
              child: Text(
                'Tổng tiền hoàn',
                style: TextStyle(
                  color: AppColors.secondary20,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            Expanded(
              child: Text(
                controller.remainingDeposit
                        .toStringTotalthis(symbol: 'đ') ??
                    '--',
                style: TextStyle(
                  color: AppColors.secondary20,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.end,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildItemRow({
    required String key,
    required String value,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.px),
      child: Row(
        children: [
          Expanded(
            child: Text(
              key,
              style: TextStyle(
                color: AppColors.secondary20,
                fontSize: 16.sp,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: AppColors.secondary20,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }

  Column _buildReason() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Lý do'.tr,
          style: TextStyle(
            fontSize: 17.sp,
            color: AppColors.secondary20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8.px),
        Text.rich(
          style: TextStyle(
            fontSize: 15.sp,
            color: AppColors.secondary40,
            fontWeight: FontWeight.w500,
          ),
          TextSpan(
            text: '${controller.returnRequestByIdModel?.reason}'.tr,
          ),
        ),
      ],
    );
  }

  Column _buildReturnDate() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ngày trả phòng'.tr,
          style: TextStyle(
            fontSize: 17.sp,
            color: AppColors.secondary20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8.px),
        Text(
          'Theo như thời hạn hợp đồng'.tr,
          style: TextStyle(
            fontSize: 15.sp,
            color: AppColors.secondary40,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8.px),
        Row(
          children: [
            const Icon(
              Icons.date_range,
              color: AppColors.secondary40,
            ),
            SizedBox(width: 5.px),
            Text(
              controller.returnRequestByIdModel?.returnDate?.ddMMyyyy ?? '--',
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
                  controller.returnRequestByIdModel?.createdUser?.fullName ??
                      '--',
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
                      controller.returnRequestByIdModel?.createdUser
                              ?.phoneNumber ??
                          '--',
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
                imageUrl:
                    controller.returnRequestByIdModel?.createdUser?.avatarUrl ??
                        ImageAssets.demo,
              ),
            ),
          ),
        ],
      ),
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
                controller.returnRequestByIdModel?.room!.title ?? '',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                controller.returnRequestByIdModel?.room!.addresses
                        ?.join(', ') ??
                    '',
                style: TextStyle(
                  color: AppColors.secondary20,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.normal,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                controller.returnRequestByIdModel?.room!.totalPrice!
                        .toStringTotalthis() ??
                    '',
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
      controller.returnRequestByIdModel?.status ?? 0,
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
