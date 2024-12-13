import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/core/widget/custom_app_bar.dart';
import 'package:smart_rent/core/widget/scaffold_widget.dart';
import 'package:smart_rent/core/widget/solid_button_widget.dart';
import 'package:smart_rent/modules/payment_transfer_info/payment_transfer_info_controller.dart';

class PaymentTransferInfoPage extends GetView<PaymentTransferInfoController> {
  const PaymentTransferInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      appBar: CustomAppBar(title: 'transfer_information'.tr),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 16.px, vertical: 8.px),
        child: Column(
          children: [
            SizedBox(height: 8.px),
            _buildGuideText(),
            SizedBox(height: 16.px),
            _buildQRBank(),
            SizedBox(height: 16.px),
            _buildButtonDownloadQRBank(),
            SizedBox(height: 16.px),
            _buildTransferInformation(),
            SizedBox(height: 16.px),
            _buildNotice(),
            SizedBox(height: 16.px),
          ],
        ),
      ),
      bottomNavigationBar: SolidButtonWidget(
        height: 55.px,
        margin: EdgeInsets.symmetric(horizontal: 16.px, vertical: 4.px),
        text: 'completed'.tr,
        onTap: controller.onOpenUploadEvidenceSheet,
      ),
    );
  }

  Container _buildNotice() {
    return Container(
      padding: EdgeInsets.all(12.px),
      decoration: BoxDecoration(
        color: AppColors.red90,
        border: Border.all(
          color: AppColors.red60,
          width: 1.px,
        ),
        borderRadius: BorderRadius.circular(8.px),
      ),
      child: Text.rich(
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.normal,
          color: AppColors.red50,
        ),
        TextSpan(text: 'transfer_note'.tr),
      ),
    );
  }

  Container _buildTransferInformation() {
    return Container(
      padding: EdgeInsets.all(16.px),
      decoration: BoxDecoration(
        color: const Color(0xffF0F2F4),
        borderRadius: BorderRadius.circular(10.px),
      ),
      child: Column(
        children: [
          _buildItemRow(
            key: 'account_holder'.tr,
            value: 'Lê Bảo Như',
            onTap: () {},
          ),
          SizedBox(height: 16.px),
          _buildItemRow(
            key: 'account_number'.tr,
            value: '10823306994',
            onTap: () {},
          ),
          SizedBox(height: 16.px),
          _buildItemRow(
            key: 'amount'.tr,
            value: '2.000.000đ',
            onTap: () {},
          ),
          SizedBox(height: 16.px),
          _buildItemRow(
            key: 'transfer_content'.tr,
            value: 'SR01239503942',
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Container _buildQRBank() {
    return Container(
      color: AppColors.error,
      width: double.infinity,
      height: 20.h,
      child: const Icon(
        Icons.qr_code,
        color: AppColors.black,
      ),
    );
  }

  Text _buildGuideText() {
    return Text.rich(
      style: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.normal,
        color: AppColors.secondary20,
      ),
      TextSpan(text: 'transfer_instruction'.tr),
    );
  }

  SolidButtonWidget _buildButtonDownloadQRBank() {
    return SolidButtonWidget(
      text: 'download'.tr,
      onTap: () {},
      backgroundColor: AppColors.primary40,
      padding: EdgeInsets.symmetric(vertical: 8.px, horizontal: 16.px),
      icon: const Icon(
        Icons.file_download_outlined,
        color: AppColors.white,
      ),
    );
  }

  Widget _buildItemRow({
    required String key,
    required String value,
    required Function() onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            key,
            style: TextStyle(
              color: AppColors.secondary40,
              fontSize: 16.sp,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        SizedBox(height: 2.px),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              value,
              style: TextStyle(
                color: AppColors.secondary20,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SolidButtonWidget(
              text: 'copy'.tr,
              height: 32.px,
              padding: EdgeInsets.symmetric(vertical: 2.px, horizontal: 8.px),
              onTap: onTap,
            )
          ],
        ),
      ],
    );
  }
}
