import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/core/enums/loading_type.dart';
import 'package:smart_rent/core/extension/double_extension.dart';
import 'package:smart_rent/core/values/image_assets.dart';
import 'package:smart_rent/core/widget/custom_app_bar.dart';
import 'package:smart_rent/core/widget/error_widget.dart';
import 'package:smart_rent/core/widget/loading_widget.dart';
import 'package:smart_rent/core/widget/scaffold_widget.dart';
import 'package:smart_rent/core/widget/solid_button_widget.dart';
import 'package:smart_rent/modules/landlord_payment_deposit/landlord_payment_deposit_controller.dart';

class LandlordPaymentDepositPage
    extends GetView<LandlordPaymentDepositController> {
  const LandlordPaymentDepositPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      appBar: CustomAppBar(title: 'deposit_payment'.tr),
      body: Obx(() => _buildListByStatus()),
      bottomNavigationBar: Obx(
        () => Visibility(
          visible: controller.isLoadingData.value == LoadingType.LOADED,
          child: SolidButtonWidget(
            height: 55.px,
            margin: EdgeInsets.symmetric(horizontal: 16.px, vertical: 4.px),
            text: 'confirm'.tr,
            onTap: controller.onNavPaymentTransferInfo,
          ),
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
      padding: EdgeInsets.symmetric(horizontal: 16.px, vertical: 16.px),
      child: Column(
        children: [
          _buildIllustration(),
          SizedBox(height: 16.px),
          _buildInfomationCard(),
        ],
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
            key: 'Mã hợp đồng'.tr,
            value: controller.returnRequestByIdModel?.contractId?.toString() ??
                '--',
          ),
          Divider(
            color: AppColors.secondary80.withOpacity(0.5),
            thickness: 1,
            height: 16.px,
          ),
          _buildItemRow(
            key: 'payment_amount'.tr,
            value: controller.returnRequestByIdModel!.totalReturnDeposit
                    ?.toStringTotalthis(symbol: 'đ') ??
                '--',
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
            value: controller.returnRequestByIdModel!.createdUser?.fullName ??
                '--',
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
            'Bạn đang hoàn tiền cọc cho phòng trọ'.tr,
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
            padding: EdgeInsets.symmetric(horizontal: 16.px),
            child: Text.rich(
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.primary40,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
              TextSpan(
                text: controller.returnRequestByIdModel?.room?.addresses
                        ?.join(', ') ??
                    '--',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
