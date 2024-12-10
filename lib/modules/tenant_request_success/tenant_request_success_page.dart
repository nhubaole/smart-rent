import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/core/routes/app_routes.dart';
import 'package:smart_rent/core/widget/scaffold_widget.dart';
import 'package:smart_rent/core/widget/solid_button_widget.dart';
import 'package:smart_rent/modules/tenant_request_success/tenant_request_success_controller.dart';

class TenantRequestSuccessPage extends GetView<TenantRequestSuccessController> {
  const TenantRequestSuccessPage({super.key});

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
                SizedBox(height: 32.px),
                _buildSuggesstNavManageInvoice(),
                SizedBox(height: 64.px),
                SolidButtonWidget(
                  margin: EdgeInsets.symmetric(horizontal: 16.px),
                  text: 'back'.tr,
                  onTap: () {
                    Get.until(
                      (route) => route.settings.name == AppRoutes.root,
                    );
                  },
                ),
              ],
            ),
          )
        ],
      ),
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
            TextSpan(text: 'view_details'.tr),
            const TextSpan(text: ' '),
            TextSpan(
              text: 'manage_bills'.tr,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const TextSpan(text: ' '),
            TextSpan(text: 'app_section'.tr),
          ],
        ),
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
      child: Text.rich(
        style: defaultTextStyle,
        textAlign: TextAlign.center,
        TextSpan(text: 'success_message'.tr),
      ),
    );
  }

  Text _buildSentSuccess() {
    return Text.rich(
      style: TextStyle(
        fontSize: 22.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.black,
      ),
      textAlign: TextAlign.center,
      TextSpan(text: 'request_success'.tr),
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
