import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/core/routes/app_routes.dart';
import 'package:smart_rent/core/values/image_assets.dart';
import 'package:smart_rent/core/widget/custom_app_bar.dart';
import 'package:smart_rent/core/widget/outline_button_widget.dart';
import 'package:smart_rent/core/widget/scaffold_widget.dart';
import 'package:smart_rent/modules/tenant_rent_return/tenant_rent_return_controller.dart';

class TenantRentReturnPage extends GetView<TenantRentReturnController> {
  const TenantRentReturnPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      appBar: CustomAppBar(title: 'rent_return'.tr),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 16.px, vertical: 8.px),
        child: Container(
          padding: EdgeInsets.all(8.px),
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.transparent,
              width: 0.5.px,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(10.px),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildTextStep(),
              SizedBox(height: 16.px),
              _buildStepItem(
                index: 1,
                pathIcon: ImageAssets.icSend2,
                title: 'send_return_request'.tr,
                description: 'send_request_to_owner'.tr,
              ),
              SizedBox(height: 16.px),
              _buildStepItem(
                index: 2,
                pathIcon: ImageAssets.icTerm,
                title: 'check_room_confirm'.tr,
                description: 'send_request_to_owner'.tr,
              ),
              SizedBox(height: 16.px),
              _buildStepItem(
                index: 3,
                pathIcon: ImageAssets.icCreditCard,
                title: 'deposit_refund'.tr,
                description: 'owner_check_room'.tr,
              ),
              SizedBox(height: 16.px),
              _buildStepItem(
                index: 4,
                pathIcon: ImageAssets.icRating1,
                title: 'rate_owner'.tr,
                description: 'rate_after_rent'.tr,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: OutlineButtonWidget(
        height: 55.px,
        margin: EdgeInsets.symmetric(horizontal: 16.px, vertical: 4.px),
        text: 'continue'.tr,
        trailing: Padding(
          padding: EdgeInsets.only(left: 8.px),
          child: Icon(
            Icons.arrow_forward_ios_rounded,
            size: 16.sp,
            color: AppColors.primary60,
          ),
        ),
        onTap: () => Get.toNamed(AppRoutes.tenantSentReturnRequest),
      ),
    );
  }

  Widget _buildStepItem({
    required int index,
    required String pathIcon,
    required String title,
    required String description,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.px, horizontal: 12.px),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.primary95,
          width: 1.px,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(10.px),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          CircleAvatar(
            radius: 16.px,
            backgroundColor: AppColors.primary40,
            child: Text(
              '$index',
              style: TextStyle(
                color: AppColors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(width: 8.px),
          Image.asset(
            pathIcon,
            width: 30.px,
            height: 30.px,
            fit: BoxFit.cover,
          ),
          SizedBox(width: 16.px),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    text: title,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.secondary20,
                    ),
                  ),
                ),
                Text.rich(
                  TextSpan(
                    text: description,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.secondary40,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Text _buildTextStep() {
    return Text.rich(
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.secondary20,
      ),
      TextSpan(text: 'return_steps'.tr),
    );
  }
}
