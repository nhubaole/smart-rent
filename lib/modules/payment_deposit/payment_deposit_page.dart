import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/core/routes/app_routes.dart';
import 'package:smart_rent/core/values/image_assets.dart';
import 'package:smart_rent/core/widget/custom_app_bar.dart';
import 'package:smart_rent/core/widget/scaffold_widget.dart';
import 'package:smart_rent/core/widget/solid_button_widget.dart';
import 'package:smart_rent/modules/payment_deposit/payment_deposit_controller.dart';

class PaymentDepositPage extends GetView<PaymentDepositController> {
  const PaymentDepositPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      appBar: CustomAppBar(title: 'deposit_payment'.tr),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 16.px, vertical: 16.px),
        child: Column(
          children: [
            _buildIllustration(),
            SizedBox(height: 16.px),
            _buildInfomationCard(),
          ],
        ),
      ),
      bottomNavigationBar: SolidButtonWidget(
        height: 55.px,
        margin: EdgeInsets.symmetric(horizontal: 16.px, vertical: 4.px),
        text: 'confirm'.tr,
        onTap: () => Get.toNamed(AppRoutes.paymentTransferInfo),
      ),
    );
  }

  Container _buildInfomationCard() {
    return Container(
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
            key: 'bill_code'.tr,
            value: 'HD2220',
          ),
          Divider(
            color: AppColors.secondary80.withOpacity(0.5),
            thickness: 1,
            height: 16.px,
          ),
          _buildItemRow(
            key: 'payment_amount'.tr,
            value: '2,500,000đ',
          ),
          Divider(
            color: AppColors.secondary80.withOpacity(0.5),
            thickness: 1,
            height: 16.px,
          ),
          _buildItemRow(
            key: 'payment_method'.tr,
            value: 'Chuyển khoản',
          ),
          Divider(
            color: AppColors.secondary80.withOpacity(0.5),
            thickness: 1,
            height: 16.px,
          ),
          _buildItemRow(
            key: 'recipient'.tr,
            value: 'Lê Bảo Như',
          ),
          Divider(
            color: AppColors.secondary80.withOpacity(0.5),
            thickness: 1,
            height: 16.px,
          ),
        ],
      ),
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
          Text(
            value,
            style: TextStyle(
              color: AppColors.secondary20,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Container _buildIllustration() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.px),
      decoration: BoxDecoration(
        color: AppColors.primary98,
        borderRadius: BorderRadius.circular(10.px),
        border: Border.all(
          color: AppColors.primary80,
          width: 1.px,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary80,
            blurRadius: 1.px,
            offset: Offset(0, 2.px),
          ),
        ],
      ),
      child: Column(
        children: [
          Image.asset(
            ImageAssets.icPayment,
            width: 105.px,
            height: 105.px,
          ),
          SizedBox(height: 16.px),
          Text(
            'paying_bill_for_room'.tr,
            style: TextStyle(
              color: AppColors.secondary20,
              fontSize: 16.sp,
              fontWeight: FontWeight.normal,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 16.px),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.px),
            child: Text.rich(
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.primary40,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
              TextSpan(
                text:
                    '97 đường số 11, phường Trường Thọ, TP Thủ Đức, TP.HCM '.tr,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
