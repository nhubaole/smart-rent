import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/core/enums/loading_type.dart';
import 'package:smart_rent/core/model/contract/contract_by_status_model.dart';
import 'package:smart_rent/core/routes/app_routes.dart';
import 'package:smart_rent/core/widget/custom_app_bar.dart';
import 'package:smart_rent/core/widget/error_widget.dart';
import 'package:smart_rent/core/widget/keep_alive_wrapper.dart';
import 'package:smart_rent/core/widget/loading_widget.dart';
import 'package:smart_rent/core/widget/outline_button_widget.dart';
import 'package:smart_rent/core/widget/scaffold_widget.dart';
import 'package:smart_rent/modules/contract/contract_controller.dart';
import 'package:smart_rent/modules/contract/widget/contract_item.dart';
import 'package:smart_rent/modules/contract/widget/contract_sample_item.dart';

class ContractPage extends GetView<ContractController> {
  const ContractPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(
        title: 'rental_contract'.tr,
      ),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return !controller.isLandlord
              ? []
              : [
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
      // bottomNavigationBar: controller.isLandlord
      //     ? OutlineButtonWidget(
      //         height: 50.px,
      //         onTap: () {},
      //         margin: EdgeInsets.only(left: 16.px, right: 16.px, bottom: 16.px),
      //         padding: EdgeInsets.zero,
      //         trailing: const Icon(
      //           Icons.edit_note_outlined,
      //           size: 20,
      //           color: AppColors.primary60,
      //         ),
      //         borderRadius: BorderRadius.circular(100),
      //         child: Text(
      //           'draft_contract'.tr,
      //           style: const TextStyle(
      //             color: AppColors.primary60,
      //             fontSize: 18,
      //             fontWeight: FontWeight.w400,
      //           ),
      //         ),
      //       )
      //     : null,
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
            child: Obx(
              () => ListView.separated(
                separatorBuilder: (context, index) => SizedBox(width: 8.px),
                shrinkWrap: true,
                itemCount: controller.contractTemplates.length,
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 16.px),
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return ContractSampleItem(
                    onCreateContract: () =>
                        Get.toNamed(AppRoutes.contractCreation, arguments: {
                      "template": controller.contractTemplates[index]
                    }),
                    onTap: () {},
                    template: controller.contractTemplates[index],
                  );
                },
              ),
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

  Widget _buildTabView() {
    return Expanded(
      child: Obx(
        () => TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          controller: controller.tabController,
          children: [
            _buildRefreshIndicator(
              onRefresh: controller.fetchPendingContracts,
              contracts: controller.pendingContracts,
              loadingType: controller.loadingPendingContracts.value,
              contractType: 0,
            ),
            _buildRefreshIndicator(
              onRefresh: controller.fetchActiveContracts,
              contracts: controller.activeContracts,
              loadingType: controller.loadingActiveContracts.value,
              contractType: 1,
            ),
            _buildRefreshIndicator(
              onRefresh: controller.fetchExpiredContracts,
              contracts: controller.expiredContracts,
              loadingType: controller.loadingExpiredContracts.value,
              contractType: 2,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRefreshIndicator({
    required Function() onRefresh,
    required List<ContractByStatusModel> contracts,
    required LoadingType loadingType,
    required int contractType,
  }) {
    return RefreshIndicator(
      onRefresh: () async {
        await onRefresh();
      },
      child: _buildListContractsByStatus(
        contracts: contracts,
        loadingType: loadingType,
        contractType: contractType,
      ),
    );
  }

  _buildListContractsByStatus({
    required List<ContractByStatusModel> contracts,
    required LoadingType loadingType,
    required int contractType,
  }) {
    switch (loadingType) {
      case LoadingType.INIT:
        return const LoadingWidget();
      case LoadingType.LOADING:
        return const LoadingWidget();
      case LoadingType.LOADED:
        return _buildListConstracts(
          contracts: contracts,
          contractType: contractType,
        );
      case LoadingType.ERROR:
        return ErrorCustomWidget(
          minHeight: Get.height / 2,
          expandToCanPullToRefresh: true,
        );
    }
  }

  Widget _buildListConstracts({
    required List<ContractByStatusModel> contracts,
    required int contractType,
  }) {
    return KeepAliveWrapper(
      wantKeepAlive: true,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Container(
          constraints: BoxConstraints(minHeight: Get.height * 3 / 4),
          child: ListView.separated(
            shrinkWrap: true,
            separatorBuilder: (context, index) => const Divider(
              color: AppColors.secondary80,
              thickness: 0.5,
              height: 0,
            ),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: contracts.length,
            itemBuilder: (context, index) {
              final contract = contracts[index];
              return ContractItem(
                contract: contract,
                onTap: () => Get.toNamed(
                  AppRoutes.contractInfo,
                  arguments: {
                    'contract': contract,
                    'contract_type': contractType,
                  },
                ),
              );
            },
          ),
        ),
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
