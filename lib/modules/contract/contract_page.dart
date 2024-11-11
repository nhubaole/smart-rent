import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/core/routes/app_routes.dart';
import 'package:smart_rent/core/widget/custom_app_bar.dart';
import 'package:smart_rent/modules/contract/contract_controller.dart';
import 'package:smart_rent/modules/contract/widget/contract_item.dart';

class ContractPage extends GetView<ContractController> {
  const ContractPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(
        title: 'rental_contract'.tr,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Obx(
          //   () => TabBar(
          //     indicatorColor: AppColors.transparent,
          //     labelColor: AppColors.white,
          //     indicatorWeight: 1,
          //     isScrollable: false,
          //     labelPadding:
          //         EdgeInsets.symmetric(horizontal: 0.px, vertical: 0.px),
          //     indicator: BoxDecoration(
          //       color: AppColors.primary40,
          //       borderRadius: BorderRadius.circular(8),
          //     ),
          //     indicatorPadding: EdgeInsets.zero,
          //     indicatorSize: TabBarIndicatorSize.label,
          //     unselectedLabelStyle: TextStyle(
          //       fontSize: 16.sp,
          //       fontWeight: FontWeight.normal,
          //       color: AppColors.secondary40,
          //     ),
          //     tabs: controller.tabs
          //         .mapIndexed(
          //           (index, e) => Tab(
          //             child: Container(
          //               alignment: Alignment.center,
          //               width: double.infinity,
          //               padding: EdgeInsets.symmetric(
          //                 horizontal: 0.px,
          //                 vertical: 8.px,
          //               ),
          //               child: Text(
          //                 e,
          //                 overflow: TextOverflow.ellipsis,
          //                 maxLines: 1,
          //               ),
          //             ),
          //           ),
          //         )
          //         .toList(),
          //     controller: controller.tabController,
          //   ),
          // ),
          SingleChildScrollView(
            child: SizedBox(
              height: 40.px,
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 16.px),
                itemCount: controller.tabs.length,
                itemBuilder: (context, index) => Obx(
                  () => Container(
                    margin: EdgeInsets.symmetric(horizontal: 4.px),
                    padding: EdgeInsets.symmetric(horizontal: 8.px),
                    decoration: BoxDecoration(
                      color: controller.selectedTab.value == index
                          ? AppColors.primary40
                          : AppColors.secondary90,
                      borderRadius: BorderRadius.circular(12.px),
                    ),
                    child: InkWell(
                      onTap: () => controller.tabController.animateTo(index),
                      borderRadius: BorderRadius.circular(12.px),
                      child: Container(
                        alignment: Alignment.center,
                        width: Get.width / controller.tabs.length - 32.px,
                        child: Text(
                          controller.tabs[index],
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: controller.selectedTab.value == index
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color: controller.selectedTab.value == index
                                ? AppColors.white
                                : AppColors.secondary40,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 8.px),
          Expanded(
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: controller.tabController,
              children: [
                ListView.separated(
                  separatorBuilder: (context, index) => const Divider(
                    color: AppColors.secondary80,
                    thickness: 0.5,
                    height: 0,
                  ),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return ContractItem(
                      onTap: () => Get.toNamed(AppRoutes.contractInfo),
                    );
                  },
                ),
                Container(),
                Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
