import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/core/enums/loading_type.dart';
import 'package:smart_rent/core/extension/int_extension.dart';
import 'package:smart_rent/core/values/image_assets.dart';
import 'package:smart_rent/core/widget/cache_image_widget.dart';
import 'package:smart_rent/core/widget/custom_app_bar.dart';
import 'package:smart_rent/core/widget/error_widget.dart';
import 'package:smart_rent/core/widget/loading_widget.dart';
import 'package:smart_rent/core/widget/scaffold_widget.dart';
import 'package:smart_rent/core/widget/solid_button_widget.dart';
import 'package:smart_rent/modules/payment_transfer_info/payment_transfer_info_controller.dart';

class PaymentTransferInfoPage extends GetView<PaymentTransferInfoController> {
  const PaymentTransferInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      appBar: CustomAppBar(title: 'transfer_information'.tr),
      body: Obx(() => _buildListByStatus()),
      bottomNavigationBar: Obx(
        () => SolidButtonWidget(
          height: 55.px,
          margin: EdgeInsets.symmetric(horizontal: 16.px, vertical: 4.px),
          text: !controller.isCompletedPaid.value
              ? 'Có thể hoàn thành trong (${controller.countDown.value} giây)'
              : 'Đã hoàn thành'.tr,
          onTap: controller.isCompletedPaid.value
              ? controller.onOpenUploadEvidenceSheet
              : null,
        ),
      ),
    );
  }

  Widget _buildListByStatus() {
    switch (controller.isLoadingData.value) {
      case LoadingType.INIT:
      case LoadingType.LOADING:
        return const LoadingWidget();
      case LoadingType.LOADED:
        return _buildBody();
      case LoadingType.ERROR:
        return const ErrorCustomWidget(
          expandToCanPullToRefresh: true,
        );
    }
  }

  SingleChildScrollView _buildBody() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 16.px, vertical: 8.px),
      child: Column(
        children: [
          SizedBox(height: 8.px),
          _buildGuideText(),
          SizedBox(height: 16.px),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              controller.paymentDetailInfoModel?.bankName ?? '',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.secondary20,
              ),
            ),
          ),
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
    );
  }

  Container _buildNotice() {
    return Container(
      padding: EdgeInsets.all(12.px),
      decoration: BoxDecoration(
        color: AppColors.red90,
        border: Border.all(
          color: AppColors.red60,
          width: 0.5.px,
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
            value: controller.paymentDetailInfoModel?.accountName ?? '',
            onTap: () => controller.onCopyText(
              controller.paymentDetailInfoModel?.accountName ?? '',
            ),
          ),
          SizedBox(height: 16.px),
          _buildItemRow(
            key: 'account_number'.tr,
            value: controller.paymentDetailInfoModel?.accountNumber ?? '',
            onTap: () => controller.onCopyText(
              controller.paymentDetailInfoModel?.accountNumber ?? '',
            ),
          ),
          SizedBox(height: 16.px),
          _buildItemRow(
            key: 'amount'.tr,
            value: controller.paymentDetailInfoModel?.amount
                    ?.toStringTotalthis(symbol: 'đ') ??
                '',
            onTap: () => controller.onCopyText(controller
                    .paymentDetailInfoModel?.amount
                    ?.toStringTotalthis(symbol: 'đ') ??
                ''),
          ),
          SizedBox(height: 16.px),
          _buildItemRow(
            key: 'transfer_content'.tr,
            value: controller.paymentDetailInfoModel?.tranferContent ?? '',
            onTap: () => controller.onCopyText(
              controller.paymentDetailInfoModel?.tranferContent ?? '',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQRBank() {
    return Container(
      color: AppColors.white,
      width: double.infinity,
      constraints: BoxConstraints(
        minHeight: 200.px,
      ),
      child: CacheImageWidget(
        imageUrl: controller.paymentDetailInfoModel?.qrUrl ?? ImageAssets.demo,
        shouldExtendCache: true,
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
      onTap: () => controller.onSaveQRCode(),
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
