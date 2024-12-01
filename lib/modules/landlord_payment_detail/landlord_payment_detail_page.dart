import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/core/enums/request_room_status.dart';
import 'package:smart_rent/core/routes/app_routes.dart';
import 'package:smart_rent/core/widget/custom_app_bar.dart';
import 'package:smart_rent/core/widget/scaffold_widget.dart';
import 'package:smart_rent/core/widget/solid_button_widget.dart';
import 'package:smart_rent/modules/landlord_payment_detail/landlord_payment_detail_controller.dart';

class LandlordPaymentDetailPage
    extends GetView<LandlordPaymentDetailController> {
  const LandlordPaymentDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      appBar: CustomAppBar(title: 'transaction_details'.tr),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 16.px, vertical: 8.px),
        child: Container(
          padding: EdgeInsets.all(16.px),
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.secondary80,
              width: 1.px,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(10.px),
            ),
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
                  transactionCode: '123456',
                  onCopy: () {},
                ),
              ),
              SizedBox(height: 20.px),
              _buildRowItem(key: 'time'.tr, value: '10:45 14/07/2023'),
              SizedBox(height: 20.px),
              _buildRowItem(key: 'payer'.tr, value: 'Nguyễn Phương'),
              SizedBox(height: 20.px),
              _buildRowItem(key: 'receiver'.tr, value: 'Lê Bảo Như'),
              SizedBox(height: 20.px),
              _buildRowItem(key: 'total_payment'.tr, value: '2.000.000 ₫'),
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
      ),
      bottomNavigationBar: SolidButtonWidget(
        height: 55.px,
        margin: EdgeInsets.symmetric(horizontal: 16.px, vertical: 4.px),
        text: 'confirm_completed'.tr,
        onTap: () =>
            Get.until((route) => route.settings.name == AppRoutes.root),
      ),
    );
  }

  Container _buildPreviewProof() {
    return Container(
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
        child: Image.asset(
          'assets/images/ic_logo_login.png',
          width: 100.px,
          height: 200.px,
          fit: BoxFit.cover,
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
    const status = RequestRoomStatus.pending;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.px, vertical: 4.px),
      decoration: BoxDecoration(
        color: RequestRoomStatus.pending.colorBackground,
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
