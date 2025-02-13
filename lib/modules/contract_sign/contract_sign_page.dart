import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signature/signature.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/core/widget/custom_app_bar.dart';
import 'package:smart_rent/core/widget/outline_button_widget.dart';
import 'package:smart_rent/core/widget/scaffold_widget.dart';
import 'package:smart_rent/core/widget/solid_button_widget.dart';
import 'package:smart_rent/modules/contract_sign/contract_sign_controller.dart';

class ContractSignPage extends GetView<ContractSignController> {
  const ContractSignPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(title: 'sign_contract'.tr),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 64.px),
            Text('sign_in_box_below'.tr),
            SizedBox(height: 32.px),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.px),
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: AppColors.secondary80),
                borderRadius: BorderRadius.circular(16.px),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.px),
                child: Signature(
                  key: const Key('signature'),
                  controller: controller.signatureController,
                  height: Get.height * 0.5,
                  backgroundColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildButtonActions(),
    );
  }

  Widget _buildButtonActions() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.px, vertical: 16.px),
      child: Row(
        children: [
          Expanded(
            child: OutlineButtonWidget(
              padding: EdgeInsets.zero,
              height: 50.px,
              onTap: controller.onSignAgain,
              text: 'resign'.tr,
            ),
          ),
          SizedBox(width: 16.px),
          Expanded(
            child: SolidButtonWidget(
              padding: EdgeInsets.zero,
              height: 50.px,
              text: 'confirm'.tr,
              onTap: controller.onConfirm,
            ),
          ),
        ],
      ),
    );
  }
}
