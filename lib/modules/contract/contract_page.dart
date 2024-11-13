import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/core/routes/app_routes.dart';
import 'package:smart_rent/core/widget/custom_app_bar.dart';
import 'package:smart_rent/core/widget/keep_alive_wrapper.dart';
import 'package:smart_rent/modules/contract/contract_controller.dart';
import 'package:smart_rent/modules/contract/widget/contract_item.dart';
import 'package:smart_rent/modules/contract/widget/contract_sample_item.dart';

class ContractPage extends GetView<ContractController> {
  const ContractPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(
        title: 'rental_contract'.tr,
      ),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  _buildSampleContract(),
                  SizedBox(height: 8.px),
                  Padding(
                    padding: EdgeInsets.only(left: 16.px),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'your_contract'.tr,
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.secondary20,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.px),
                ],
              ),
            ),
          ];
        },
        scrollDirection: Axis.vertical,
        physics: const ClampingScrollPhysics(),
        body: Container(
          constraints: BoxConstraints(maxHeight: Get.height * 1.5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildContractList(),
            ],
          ),
        ),
      ),
    );
  }

  Column _buildSampleContract() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 16.px),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'contract_template'.tr,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.secondary20,
                ),
                textAlign: TextAlign.start,
              ),
              SizedBox(width: 8.px),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.refresh,
                  size: 22.px,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8.px),
        KeepAliveWrapper(
          wantKeepAlive: true,
          child: SizedBox(
            height: 150.px,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: 10,
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 16.px),
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return ContractSampleItem(
                  onCreateContract: () {},
                );
              },
            ),
          ),
        ),
        SizedBox(height: 8.px),
      ],
    );
  }

  Expanded _buildContractList() {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          _buildTabbar(),
          SizedBox(height: 8.px),
          _buildTabView(),
        ],
      ),
    );
  }

  Expanded _buildTabView() {
    return Expanded(
      child: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller.tabController,
        children: [
          RefreshIndicator(
            onRefresh: () async {
              return Future.delayed(const Duration(seconds: 1), () {});
            },
            child: KeepAliveWrapper(
              wantKeepAlive: true,
              child: SingleChildScrollView(
                child: ListView.separated(
                  shrinkWrap: true,
                  separatorBuilder: (context, index) => const Divider(
                    color: AppColors.secondary80,
                    thickness: 0.5,
                    height: 0,
                  ),
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 100,
                  itemBuilder: (context, index) {
                    return ContractItem(
                      onTap: () => Get.toNamed(AppRoutes.contractInfo),
                    );
                  },
                ),
              ),
            ),
          ),
          Container(),
          Container(),
        ],
      ),
    );
  }

  SingleChildScrollView _buildTabbar() {
    return SingleChildScrollView(
      child: SizedBox(
        height: 48.px,
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: 16.px),
          itemCount: controller.tabs.length,
          itemBuilder: (context, index) => Obx(
            () => Container(
              margin: EdgeInsets.only(left: 4.px, right: 4.px, top: 8.px),
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
    );
  }
}
