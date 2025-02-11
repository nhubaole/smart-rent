import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/core/enums/loading_type.dart';
import 'package:smart_rent/core/enums/type_faculty.dart';
import 'package:smart_rent/core/extension/datetime_extension.dart';
import 'package:smart_rent/core/widget/custom_app_bar.dart';
import 'package:smart_rent/core/widget/error_widget.dart';
import 'package:smart_rent/core/widget/keep_alive_wrapper.dart';
import 'package:smart_rent/core/widget/loading_widget.dart';
import 'package:smart_rent/core/widget/outline_button_widget.dart';
import 'package:smart_rent/core/widget/scaffold_widget.dart';
import 'package:smart_rent/modules/manage_electricity_water_index/manage_electricity_water_index_controller.dart';
import 'package:smart_rent/modules/manage_electricity_water_index/widgets/electric_water_index_widget.dart';

class ManageElectricityWaterIndexPage
    extends GetView<ManageElectricityWaterIndexController> {
  const ManageElectricityWaterIndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(title: 'electricity_water_index'.tr),
      body: Obx(() => _buildBody(context)),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildTabbar(),
        SizedBox(height: 20.px),
        _buildDropDownSelection(context),
        SizedBox(height: 20.px),
        Expanded(
          child: _buildListByStatus(context),
        ),
      ],
    );
  }

  Widget _buildListByStatus(BuildContext context) {
    switch (controller.isLoadingType.value) {
      case LoadingType.INIT:
      case LoadingType.LOADING:
        return const LoadingWidget();
      case LoadingType.LOADED:
        return _buildTabView(context);
      case LoadingType.ERROR:
        return RefreshIndicator(
          onRefresh: () async {
            await controller.fetchData();
          },
          child: const ErrorCustomWidget(
            expandToCanPullToRefresh: true,
          ),
        );
    }
  }

  Widget _buildTabView(BuildContext context) {
    return TabBarView(
      controller: controller.tabController,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        _buildTableForRent(context),
        // Container(),
      ],
    );
  }

  Widget _buildTableForRent(BuildContext context) {
    if (controller.billingIndexs.isEmpty) {
      return RefreshIndicator(
        onRefresh: () async {
          await controller.fetchData();
        },
        child: ErrorCustomWidget(
          expandToCanPullToRefresh: true,
          title: 'Chưa có dữ liệu',
          child: OutlineButtonWidget(
            onTap: controller.fetchData,
            text: 'Tải lại',
            padding: EdgeInsets.symmetric(vertical: 1.h),
            margin: EdgeInsets.symmetric(
              horizontal: Get.width / 3,
              vertical: 16.px,
            ),
          ),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        await controller.fetchData();
      },
      child: KeepAliveWrapper(
        wantKeepAlive: true,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) => SizedBox(
              height: 2.h,
            ),
            itemCount: controller.billingIndexs.length,
            itemBuilder: (context, index) {
              final item = controller.billingIndexs[index];
              return ElectricWaterIndexWidget(
                indexInfoPosition: index,
                billingIndexs: item,
                onWriteIndex: controller.onCreateNewIndex,
              );
            },
          ),
        ),
      ),
    );
  }

  

  Padding _buildDropDownSelection(BuildContext context) {
    final textStyle = TextStyle(
      fontSize: 16.sp,
      color: AppColors.secondary20,
      fontWeight: FontWeight.w600,
    );
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.px),
      child: Row(
        children: [
          Obx(
            () => Expanded(
              child: Container(
                padding: EdgeInsets.all(8.px),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.px),
                  border: Border.all(color: AppColors.secondary60, width: 1.px),
                ),
                child: Theme(
                  data: Theme.of(context).copyWith(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                  ),
                  child: DropdownButton(
                    focusColor: AppColors.transparent,
                    underline: const SizedBox(),
                    isExpanded: true,
                    hint: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'type'.tr,
                              style: textStyle.copyWith(
                                color: AppColors.secondary40,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            Text(
                              controller.typeSelected.value.name,
                              style: textStyle,
                            ),
                          ],
                        ),
                        const Icon(
                          Icons.keyboard_arrow_down,
                          color: AppColors.secondary20,
                        ),
                      ],
                    ),
                    iconSize: 0.px,
                    items: controller.types
                        .map<DropdownMenuItem<TypeFaculty>>((TypeFaculty type) {
                      return DropdownMenuItem<TypeFaculty>(
                        value: type,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(type.name),
                            if (controller.typeSelected.value == type)
                              const Icon(Icons.check,
                                  color: AppColors.primary40),
                          ],
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      controller.typeSelected.value = value as TypeFaculty;
                      controller.fetchData();
                    },
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 8.px),
          Obx(
            () => Expanded(
              child: Container(
                padding: EdgeInsets.all(8.px),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.px),
                  border: Border.all(color: AppColors.secondary60, width: 1.px),
                ),
                child: Theme(
                  data: Theme.of(context).copyWith(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                  ),
                  child: DropdownButton(
                    underline: const SizedBox(),
                    isExpanded: true,
                    hint: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'period'.tr,
                              style: textStyle.copyWith(
                                color: AppColors.secondary40,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            Text(
                              controller.periodSelected.value.toPediod,
                              style: textStyle,
                            ),
                          ],
                        ),
                        const Icon(
                          Icons.keyboard_arrow_down,
                          color: AppColors.secondary20,
                        ),
                      ],
                    ),
                    iconSize: 0.px,
                    items: controller.periods
                        .map<DropdownMenuItem<DateTime>>((DateTime period) {
                      return DropdownMenuItem<DateTime>(
                        value: period,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(period.toPediod),
                            if (controller.periodSelected.value == period)
                              const Icon(Icons.check,
                                  color: AppColors.primary40),
                          ],
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      controller.periodSelected.value = value!;
                      controller.fetchData();
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabbar() {
    return SingleChildScrollView(
      child: Container(
        alignment: Alignment.center,
        height: 48.px,
        child: Center(
          child: ListView.separated(
            separatorBuilder: (context, index) => SizedBox(width: 4.px),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: controller.tabs.length,
            padding: EdgeInsets.symmetric(horizontal: 16.px),
            itemBuilder: (context, index) => Obx(
              () => Container(
                margin: EdgeInsets.only(top: 8.px),
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
    );
  }
}
