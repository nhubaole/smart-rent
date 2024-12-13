import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/core/widget/outline_button_widget.dart';
import 'package:smart_rent/core/widget/scaffold_widget.dart';
import 'package:smart_rent/core/widget/solid_button_widget.dart';
import 'package:smart_rent/modules/tenant_return_success/tenant_return_success_controller.dart';

class TenantReturnSuccessPage extends GetView<TenantReturnSuccessController> {
  const TenantReturnSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      body: Stack(
        children: [
          _buildBackground(),
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildCheckIcon(),
                SizedBox(height: 16.px),
                _buildSentSuccess(),
                SizedBox(height: 16.px),
                _buildSentSuccessDes(),
                SizedBox(height: 16.px),
                _buildSuggesstNavTenantRating(),
                SizedBox(height: 64.px),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.px),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: OutlineButtonWidget(
                          text: 'do_it_later'.tr,
                          onTap: controller.onDoItLater,
                        ),
                      ),
                      SizedBox(width: 16.px),
                      Expanded(
                        flex: 3,
                        child: SolidButtonWidget(
                          text: 'review'.tr,
                          onTap: controller.onNavReview,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSentSuccessDes() {
    final defaultTextStyle = TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.normal,
      color: AppColors.black,
    );
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.px),
      child: Column(
        children: [
          Text.rich(
            style: defaultTextStyle,
            textAlign: TextAlign.center,
            TextSpan(text: 'room_return_message'.tr),
          ),
          SizedBox(height: 32.px),
          Text.rich(
            style: defaultTextStyle,
            textAlign: TextAlign.center,
            TextSpan(text: 'deposit_refund_message'.tr),
          ),
        ],
      ),
    );
  }

  Widget _buildSuggesstNavTenantRating() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32.px),
      child: Text.rich(
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.normal,
          color: AppColors.black,
        ),
        textAlign: TextAlign.center,
        TextSpan(
          children: [
            TextSpan(text: 'let'.tr),
            const TextSpan(text: ' '),
            TextSpan(
              text: 'review_the_room'.tr,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const TextSpan(text: ' '),
            TextSpan(text: 'review_prompt'.tr),
          ],
        ),
      ),
    );
  }

  Text _buildSentSuccess() {
    return Text.rich(
      style: TextStyle(
        fontSize: 22.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.secondary20,
      ),
      textAlign: TextAlign.center,
      TextSpan(text: 'room_return_success'.tr),
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
