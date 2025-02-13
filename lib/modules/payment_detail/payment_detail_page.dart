import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/core/enums/loading_type.dart';
import 'package:smart_rent/core/enums/request_room_status.dart';
import 'package:smart_rent/core/extension/datetime_extension.dart';
import 'package:smart_rent/core/extension/double_extension.dart';
import 'package:smart_rent/core/routes/app_routes.dart';
import 'package:smart_rent/core/values/image_assets.dart';
import 'package:smart_rent/core/widget/cache_image_widget.dart';
import 'package:smart_rent/core/widget/custom_app_bar.dart';
import 'package:smart_rent/core/widget/error_widget.dart';
import 'package:smart_rent/core/widget/loading_widget.dart';
import 'package:smart_rent/core/widget/outline_button_widget.dart';
import 'package:smart_rent/core/widget/scaffold_widget.dart';
import 'package:smart_rent/core/widget/solid_button_widget.dart';
import 'package:smart_rent/modules/payment_detail/payment_detail_controller.dart';

class PaymentDetailPage extends GetView<PaymentDetailController> {
  const PaymentDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      appBar: CustomAppBar(title: 'transaction_details'.tr),
      body: Obx(() => _buildWidgetByStatus()),
      bottomNavigationBar: Obx(() => _buildButtonNavBar()),
    );
  }

  Widget _buildButtonNavBar() {
    if (controller.isLoadingData.value != LoadingType.LOADED ||
        !controller.isMustShowNav) {
      return const SizedBox.shrink();
    }
    return _buildBottomNavByType();
  }

  Widget _buildBottomNavByType() {
    if (controller.notificationModel != null) {
      if (controller.paymentAllModel!.status! == 1) return const SizedBox();
      return _buildBottomNavOption(
        title: 'Xác nhận đã hoàn thành',
        onTap: controller.onConfirmCompletedPayment,
      );
    }
    if (controller.paymentAllModel!.contractId != null) {
      return _buildBottomNavOption(
        title: 'Xem phụ lục hợp đồng',
        onTap: controller.onNavTypeContract,
      );
    }
    if (controller.paymentAllModel!.billId != null) {
      return _buildBottomNavOption(
        title: 'Xem phụ lục hoá đơn',
        onTap: controller.onNavTypeBill,
      );
    }
    if (controller.paymentAllModel!.returnRequestId != null) {
      return _buildBottomNavOption(
        title: 'Xem yêu cầu trả phòng'.tr,
        onTap: controller.onNavTypeReturn,
      );
    }

    return const SizedBox();
  }

  Widget _buildWidgetByStatus() {
    switch (controller.isLoadingData.value) {
      case LoadingType.INIT:
      case LoadingType.LOADING:
        return const LoadingWidget();
      case LoadingType.LOADED:
        return _buildDetailPayment();
      case LoadingType.ERROR:
        return const ErrorCustomWidget(
          expandToCanPullToRefresh: true,
        );
      default:
        return const SizedBox();
    }
  }

  Widget _buildBottomNavOption({
    String? title,
    required Function() onTap,
  }) {
    return OutlineButtonWidget(
      height: 55.px,
      margin: EdgeInsets.symmetric(horizontal: 16.px, vertical: 4.px),
      text: title ?? 'continue'.tr,
      onTap: onTap,
      leading: Icon(
        FontAwesomeIcons.eye,
        size: 16.sp,
        color: AppColors.primary60,
      ),
    );
  }

  SolidButtonWidget _buildBottomNav() {
    return SolidButtonWidget(
      height: 55.px,
      margin: EdgeInsets.symmetric(horizontal: 16.px, vertical: 4.px),
      text: 'continue'.tr,
      onTap: () => Get.until((route) => route.settings.name == AppRoutes.root),
    );
  }

  SingleChildScrollView _buildDetailPayment() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 16.px, vertical: 8.px),
      child: Container(
        padding: EdgeInsets.all(16.px),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.secondary80, width: 1.px),
          borderRadius: BorderRadius.all(Radius.circular(10.px)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildLogo(),
            SizedBox(height: 20.px),
            _buildRowItem(
              key: 'status'.tr,
              child: _buildStatus(),
            ),
            SizedBox(height: 20.px),
            _buildRowItem(
              key: 'transaction_code'.tr,
              child: _buildCopyTransactionCode(
                transactionCode: controller.paymentAllModel!.code ?? '',
                onCopy: controller.onCopyTransactionCode,
              ),
            ),
            SizedBox(height: 20.px),
            _buildRowItem(
                key: 'time'.tr,
                value:
                    controller.paymentAllModel!.paidTime?.hhmmDDMMyyyy ?? ''),
            SizedBox(height: 20.px),
            _buildRowItem(key: 'payer'.tr, value: controller.sender!.fullName),
            SizedBox(height: 20.px),
            _buildRowItem(
                key: 'receiver'.tr, value: controller.receivedUser.fullName),
            SizedBox(height: 20.px),
            _buildRowItem(
                key: 'total_payment'.tr,
                value:
                    '${controller.paymentAllModel!.amount?.toFormatCurrency ?? '0'}₫'),
            SizedBox(height: 20.px),
            _buildRowItem(key: 'payment_method'.tr, value: 'Chuyển khoản'),
            SizedBox(height: 20.px),
            _buildRowItem(
              crossAxisAlignment: CrossAxisAlignment.start,
              key: 'proof'.tr,
              child: _buildPreviewProof(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPreviewProof() {
    return InkWell(
      onTap: controller.onViewProod,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.secondary80,
            width: 0.4.px,
          ),
          borderRadius: BorderRadius.circular(8.px),
          color: AppColors.secondary60,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.px),
          child: CacheImageWidget(
            imageUrl:
                controller.paymentAllModel!.evidenceImage ?? ImageAssets.demo,
            width: 100.px,
            height: 200.px,
            fit: BoxFit.cover,
            shouldExtendCache: true,
          ),
        ),
      ),
    );
  }

  Widget _buildCopyTransactionCode({
    required String transactionCode,
    required Function() onCopy,
  }) {
    return InkWell(
      onTap: onCopy,
      borderRadius: BorderRadius.circular(20.px),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.px, vertical: 4.px),
        alignment: Alignment.centerRight,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              transactionCode,
              style: TextStyle(
                color: AppColors.secondary20,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(width: 4.px),
            Icon(
              Icons.copy,
              color: AppColors.secondary20,
              size: 18.px,
            ),
          ],
        ),
      ),
    );
  }

  Container _buildStatus() {
    RequestRoomStatus status;
    switch (controller.paymentAllModel!.status!) {
      case 0:
        status = RequestRoomStatus.pending;
        break;
      case 1:
        status = RequestRoomStatus.accepted;
        break;
      default: // 2
        status = RequestRoomStatus.rejected;
        break;
    }
    
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.px, vertical: 4.px),
      decoration: BoxDecoration(
        color: status.colorBackground,
        borderRadius: BorderRadius.circular(20.px),
      ),
      child: Text(
        status.value,
        style: TextStyle(
          color: status.colorContent,
          fontSize: 16.sp,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _buildRowItem({
    required String key,
    String? value,
    Widget? child,
    MainAxisAlignment? mainAxisAlignment,
    CrossAxisAlignment? crossAxisAlignment,
  }) {
    assert(value == null || child == null,
        'Only one of value or child can be non-null');
    return Row(
      mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.spaceBetween,
      crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          key,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.secondary40,
          ),
        ),
        if (child != null) child,
        if (value != null)
          Text(
            value,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.secondary20,
            ),
          ),
      ],
    );
  }

  Row _buildLogo() {
    return Row(
      children: [
        Image.asset(
          'assets/images/ic_logo_login.png',
          width: 35.px,
          height: 40.px,
        ),
        SizedBox(width: 16.px),
        Expanded(
          child: Text.rich(
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.secondary20,
            ),
            TextSpan(
              text: 'bill_payment'.tr,
            ),
          ),
        )
      ],
    );
  }
}
