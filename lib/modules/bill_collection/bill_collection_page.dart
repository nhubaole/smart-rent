import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/core/routes/app_routes.dart';
import 'package:smart_rent/core/widget/custom_app_bar.dart';
import 'package:smart_rent/core/widget/keep_alive_wrapper.dart';
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
            child: _buildTabBarView(),
          )
        ],
      ),
    );
  }

  Widget _buildTabBarView() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.px),
      child: TabBarView(
        controller: controller.tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          KeepAliveWrapper(
            wantKeepAlive: true,
            child: RefreshIndicator(
              onRefresh: () => Future.delayed(Duration(seconds: 1)),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: ListView.separated(
                  separatorBuilder: (context, index) => SizedBox(height: 16.px),
                  itemCount: 10,
                  padding: EdgeInsets.symmetric(vertical: 16.px),
                  scrollDirection: Axis.vertical,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return BillCollectionItem(
                      onTap: () => Get.toNamed(AppRoutes.billInfo),
                    );
                  },
                ),
              ),
            ),
          ),
          Container(),
        ],
      ),
    );
  }

  Widget _buildTabbar() {
    return Obx(
      () => TabBar(
        controller: controller.tabController,
        tabs: controller.tabs.map((e) {
          final index = controller.tabs.indexOf(e);
          return Container(
            padding: EdgeInsets.all(8.px),
            constraints: BoxConstraints(minWidth: Get.width / 2 - 32.px),
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
