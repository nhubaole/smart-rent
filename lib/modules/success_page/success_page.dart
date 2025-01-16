import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/core/widget/outline_button_widget.dart';
import 'package:smart_rent/core/widget/scaffold_widget.dart';
import 'package:smart_rent/core/widget/solid_button_widget.dart';
import 'package:smart_rent/modules/success_page/success_controller.dart';

class SuccessPage extends GetView<SuccessController> {
  const SuccessPage({super.key});

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
                _buildPaymentSuccessText(),
                SizedBox(height: 16.px),
                _buildContentThankYou(),
                SizedBox(height: 32.px),
                _buildSuggesstNavManageInvoice(),
                SizedBox(height: 32.px),
                _buildButtons(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Row _buildButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        if (controller.successArgument?.leftButtonOnTap != null)
          OutlineButtonWidget(
            height: 50.px,
            padding: EdgeInsets.symmetric(
              horizontal: 32.px,
              vertical: 2.px,
            ),
            text: controller.successArgument?.leftButtonText ?? 'Trở về'.tr,
            onTap: controller.successArgument?.leftButtonOnTap,
          ),
        if (controller.successArgument?.rightButtonOnTap != null)
          SolidButtonWidget(
            height: 50.px,
            padding: EdgeInsets.symmetric(
              horizontal: 32.px,
              vertical: 2.px,
            ),
            text: controller.successArgument?.rightButtonText ??
                'transaction_details'.tr,
            onTap: controller.successArgument?.rightButtonOnTap,
          )
      ],
    );
  }

  Widget _buildSuggesstNavManageInvoice() {
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
            TextSpan(
                text:
                    controller.successArgument?.fifthText ?? 'view_details'.tr),
          ],
        ),
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
            TextSpan(
                text: controller.successArgument?.secondText ?? 'thank_you'.tr),
          ),
          Text.rich(
            style: defaultTextStyle,
            textAlign: TextAlign.center,
            TextSpan(
                text: controller.successArgument?.thirdText ??
                    'please_wait_landlord'.tr),
          ),
          SizedBox(height: 16.px),
          Text.rich(
            style: defaultTextStyle,
            textAlign: TextAlign.center,
            TextSpan(
                text: controller.successArgument?.fourthText ?? 'reminder'.tr),
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
      TextSpan(
          text: controller.successArgument?.firstText ?? 'payment_success'.tr),
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
}
