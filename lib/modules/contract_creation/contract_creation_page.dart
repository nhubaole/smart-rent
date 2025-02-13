import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/core/widget/custom_app_bar.dart';
import 'package:smart_rent/core/widget/outline_button_widget.dart';
import 'package:smart_rent/core/widget/scaffold_widget.dart';
import 'package:smart_rent/core/widget/solid_button_widget.dart';
import 'package:smart_rent/core/widget/stepper_widget.dart';
import 'package:smart_rent/modules/contract_creation/contract_creation_controller.dart';
import 'package:smart_rent/modules/contract_creation/sub_page/contract_creation_part_landlord.dart';
import 'package:smart_rent/modules/contract_creation/sub_page/contract_creation_part_policy.dart';
import 'package:smart_rent/modules/contract_creation/sub_page/contract_creation_part_preview.dart';
import 'package:smart_rent/modules/contract_creation/sub_page/contract_creation_part_room_info.dart';

class ContractCreationPage extends GetView<ContractCreationController> {
  const ContractCreationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {},
      child: ScaffoldWidget(
        appBar: CustomAppBar(title: 'create_contract_template'.tr),
        body: Obx(
          () => Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: StepperWidget<Map<String, dynamic>>(
                  tabs: controller.tabs.value,
                  initStep: controller.selectedTab.value,
                  onStepTapped: (p0) async {
                    final result = await controller.onStepTapped(p0);
                    return result;
                  },
                  selectedColor: AppColors.primary40,
                  unselectedColor: AppColors.secondary60,
                ),
              ),
              SizedBox(height: 16.px),
              Expanded(
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: controller.tabController,
                  children: const [
                    ContractCreationPartLandlord(),
                    ContractCreationPartRoomInfo(),
                    ContractCreationPartPolicy(),
                    // ContractCreationPartPreview(),
                  ],
                ),
              ),
              if (controller.selectedTab.value <
                  controller.tabs.value.length - 1)
                OutlineButtonWidget(
                  margin:
                      EdgeInsets.symmetric(horizontal: 16.px, vertical: 8.px),
                  onTap: controller.onNextPage,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'continue'.tr,
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: AppColors.primary60,
                        ),
                      ),
                      SizedBox(width: 8.px),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: AppColors.primary60,
                        size: 16.px,
                      ),
                    ],
                  ),
                ),
              if (controller.selectedTab.value ==
                  controller.tabs.value.length - 1)
                SolidButtonWidget(
                  margin:
                      EdgeInsets.symmetric(horizontal: 16.px, vertical: 8.px),
                  text: 'create_contract_template'.tr,
                  onTap: controller.onSubmit,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
