import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signature/signature.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/core/widget/custom_app_bar.dart';
import 'package:smart_rent/core/widget/scaffold_widget.dart';
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
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.px, vertical: 16.px),
        child: Row(
          children: [
            Expanded(
              child: InkWell(
                borderRadius: BorderRadius.circular(20.px),
                onTap: () => controller.onSignAgain(),
                child: Container(
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.px),
                    border: Border.all(width: 1.5, color: AppColors.primary60),
                  ),
                  child: Text(
                    'resign'.tr,
                    style: const TextStyle(
                        color: AppColors.primary60,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            SizedBox(width: 16.px),
            Expanded(
              child: InkWell(
                borderRadius: BorderRadius.circular(20.px),
                onTap: () => controller.onConfirm(),
                child: Container(
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.px),
                    color: AppColors.primary40,
                  ),
                  child: Text(
                    'confirm'.tr,
                    style: const TextStyle(
                        color: AppColors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
