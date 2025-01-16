import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/core/enums/loading_type.dart';
import 'package:smart_rent/core/widget/custom_app_bar.dart';
import 'package:smart_rent/core/widget/error_widget.dart';
import 'package:smart_rent/core/widget/keep_alive_wrapper.dart';
import 'package:smart_rent/core/widget/loading_widget.dart';
import 'package:smart_rent/core/widget/outline_button_widget.dart';
import 'package:smart_rent/core/widget/scaffold_widget.dart';
import 'package:smart_rent/modules/bill_collection/bill_collection_controller.dart';
import 'package:smart_rent/modules/bill_collection/widgets/bill_collection_item.dart';

class BillCollectionPage extends GetView<BillCollectionController> {
  const BillCollectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(title: 'bill_collection'.tr),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildTabbar(),
          Expanded(
            child: Obx(() => _buildListByStatus()),
          ),
        ],
      ),
    );
  }


  Widget _buildListByStatus() {
    switch (controller.isLoadingData.value) {
      case LoadingType.INIT:
      case LoadingType.LOADING:
        return const LoadingWidget();
      case LoadingType.LOADED:
        return _buildTabBarView();
      case LoadingType.ERROR:
        return const ErrorCustomWidget(
          expandToCanPullToRefresh: true,
        );
    }
  }

  Widget _buildTabBarView() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.px),
      child: TabBarView(
        controller: controller.tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          _buildBillingUnPaid(),
          _buildBillingWaitToConfirm(),
          _buildBillingPaid(),
        ],
      ),
    );
  }

  Widget _buildBillingPaid() {
    if (controller.billingPaided.isEmpty) {
      return _buildButtonReloadData(
        onTap: () => controller.fetchBillings(),
      );
    }
    return KeepAliveWrapper(
      wantKeepAlive: true,
      child: RefreshIndicator(
        onRefresh: () async {
          await controller.fetchBillings();
        },
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            alignment: Alignment.topCenter,
            constraints: BoxConstraints(minHeight: Get.height * 1.1),
            child: ListView.separated(
              separatorBuilder: (context, index) => SizedBox(height: 16.px),
              itemCount: controller.billingPaided.length,
              padding: EdgeInsets.symmetric(vertical: 16.px),
              scrollDirection: Axis.vertical,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final item = controller.billingPaided[index];
                return BillCollectionItem(
                  // onTap: () => Get.toNamed(AppRoutes.billInfo),
                  onTap: () => controller.onNavBillInfo(item),
                  billByStatusModel: item,
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Center _buildButtonReloadData({
    required Function() onTap,
  }) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text('Không có hóa đơn'),
          SizedBox(height: 4.h),
          OutlineButtonWidget(
            padding: EdgeInsets.all(2.w),
            margin: EdgeInsets.symmetric(horizontal: Get.width / 4),
            onTap: onTap,
            text: 'Tải lại dữ liệu',
          )
        ],
      ),
    );
  }

  Widget _buildBillingWaitToConfirm() {
    if (controller.billingUnpaid.isEmpty) {
      return _buildButtonReloadData(
        onTap: () => controller.fetchBillings(),
      );
    }
    return KeepAliveWrapper(
      wantKeepAlive: true,
      child: RefreshIndicator(
        onRefresh: () async {
          await controller.fetchBillings();
        },
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: ListView.separated(
            separatorBuilder: (context, index) => SizedBox(height: 16.px),
            itemCount: controller.billingWaitToConfirm.length,
            padding: EdgeInsets.symmetric(vertical: 16.px),
            scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final item = controller.billingWaitToConfirm[index];
              return BillCollectionItem(
                // onTap: () => Get.toNamed(AppRoutes.billInfo),
                onTap: () => controller.onNavBillInfo(item),
                billByStatusModel: item,
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildBillingUnPaid() {
    if (controller.billingUnpaid.isEmpty) {
      return _buildButtonReloadData(
        onTap: () => controller.fetchBillings(),
      );
    }
    return KeepAliveWrapper(
      wantKeepAlive: true,
      child: RefreshIndicator(
        onRefresh: () async {
          await controller.fetchBillings();
        },
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: ListView.separated(
            separatorBuilder: (context, index) => SizedBox(height: 16.px),
            itemCount: controller.billingUnpaid.length,
            padding: EdgeInsets.symmetric(vertical: 16.px),
            scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final item = controller.billingUnpaid[index];
              return BillCollectionItem(
                // onTap: () => Get.toNamed(AppRoutes.billInfo),
                onTap: () => controller.onNavBillInfo(item),
                billByStatusModel: item,
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTabbar() {
    return Obx(
      () => TabBar(
        padding: EdgeInsets.zero,
        controller: controller.tabController,
        tabAlignment: TabAlignment.center,
        tabs: controller.tabs.map((e) {
          final index = controller.tabs.indexOf(e);
          return Container(
            padding: EdgeInsets.all(8.px),
            // constraints: BoxConstraints(maxHeight: Get.width / 3 - 32.px),
            width: Get.width / 3 - 32.px,
            decoration: BoxDecoration(
              color: controller.selectedTab.value == index
                  ? AppColors.primary40
                  : AppColors.secondary90,
              borderRadius: BorderRadius.circular(8.px),
            ),
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
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          );
        }).toList(),
        dividerColor: AppColors.transparent,
        overlayColor: WidgetStateProperty.all<Color>(Colors.transparent),
        unselectedLabelColor: AppColors.transparent,
        indicatorColor: AppColors.transparent,
        onTap: (index) => controller.selectedTab.value = index,
      ),
    );
  }
}
