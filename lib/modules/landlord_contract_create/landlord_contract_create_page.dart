import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/core/widget/custom_app_bar.dart';
import 'package:smart_rent/core/widget/outline_button_widget.dart';
import 'package:smart_rent/core/widget/scaffold_widget.dart';
import 'package:smart_rent/core/widget/solid_button_widget.dart';
import 'package:smart_rent/core/widget/stepper_widget.dart';
import 'package:smart_rent/modules/landlord_contract_create/landlord_contract_create_controller.dart';
import 'package:smart_rent/modules/landlord_contract_create/views/content_rent_contract.dart';
import 'package:smart_rent/modules/landlord_contract_create/views/preview_contract.dart';
import 'package:smart_rent/modules/landlord_contract_create/views/responsibilities_party.dart';

class LandlordContractCreatePage
    extends GetView<LandlordContractCreateController> {
  const LandlordContractCreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      appBar: CustomAppBar(
        title: 'Soạn thảo hợp đồng',
        onBack: controller.onBack,
      ),
      body: Obx(
        () => _buildBody(),
      ),
      bottomNavigationBar: Obx(() => _buildButtonNav()),
    );
  }

  Column _buildBody() {
    return Column(
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
              ContentRentContract(),
              ResponsibilitiesParty(),
              PreviewContract(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildButtonNav() {
    if (controller.selectedTab.value == controller.tabs.value.length - 1) {
      return SolidButtonWidget(
        height: 50.px,
        margin: EdgeInsets.symmetric(horizontal: 16.px, vertical: 8.px),
        padding: EdgeInsets.zero,
        onTap: controller.onClickBottomNav,
        text: 'create_contract'.tr,
        icon: Icon(
          Icons.add_box_rounded,
          size: 20.px,
          color: AppColors.white,
        ),
      );
    }
    return OutlineButtonWidget(
      height: 50.px,
      margin: EdgeInsets.symmetric(horizontal: 16.px, vertical: 8.px),
      padding: EdgeInsets.zero,
      onTap: () async {
        await controller.onClickBottomNav();
      },
      text: 'Tiếp tục',
      trailing: Icon(
        Icons.arrow_forward_ios_outlined,
        size: 20.px,
        color: AppColors.primary60,
      ),
    );
  }
}
