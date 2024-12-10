import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/core/routes/app_routes.dart';
import 'package:smart_rent/core/widget/outline_button_widget.dart';
import 'package:smart_rent/core/widget/scaffold_widget.dart';
import 'package:smart_rent/modules/tenant_return_rating_success/tenant_return_rating_success_controller.dart';

class TenantReturnRatingSuccessPage
    extends GetView<TenantReturnRatingSuccessController> {
  const TenantReturnRatingSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      body: Stack(
        children: [
          _buildBackground(),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.px),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildCheckIcon(),
                  SizedBox(height: 16.px),
                  _buildPaymentSuccessText(),
                  SizedBox(height: 16.px),
                  _buildContentThankYou(),
                  SizedBox(height: 64.px),
                  OutlineButtonWidget(
                    text: 'back_home'.tr,
                    onTap: () => Get.until(
                      (route) => route.settings.name == AppRoutes.root,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContentThankYou() {
    final defaultTextStyle = TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.normal,
      color: AppColors.black,
    );
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.px),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text.rich(
            style: defaultTextStyle,
            textAlign: TextAlign.center,
            TextSpan(text: 'thank_sent_review'.tr),
          ),
          SizedBox(height: 16.px),
          Text.rich(
            style: defaultTextStyle,
            textAlign: TextAlign.center,
            TextSpan(text: 'thank_review_message'.tr),
          ),
        ],
      ),
    );
  }

  Text _buildPaymentSuccessText() {
    return Text.rich(
      style: TextStyle(
        fontSize: 22.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.black,
      ),
      textAlign: TextAlign.center,
      TextSpan(text: 'successful_review'.tr),
    );
  }

  Container _buildBackground() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFCAF0F8),
            Color(0xffFFFFFF),
          ],
        ),
      ),
    );
  }

  Container _buildCheckIcon() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.green20,
          width: 1.px,
        ),
        shape: BoxShape.circle,
      ),
      child: Padding(
        padding: EdgeInsets.all(12.px),
        child: CircleAvatar(
          backgroundColor: AppColors.green20,
          radius: 48.px,
          child: Icon(
            Icons.check_rounded,
            color: AppColors.white,
            size: 48.px,
          ),
        ),
      ),
    );
  }
}
