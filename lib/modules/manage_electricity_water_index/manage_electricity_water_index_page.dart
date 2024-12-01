import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/core/enums/type_faculty.dart';
import 'package:smart_rent/core/extension/datetime_extension.dart';
import 'package:smart_rent/core/widget/custom_app_bar.dart';
import 'package:smart_rent/core/widget/keep_alive_wrapper.dart';
import 'package:smart_rent/core/widget/scaffold_widget.dart';
import 'package:smart_rent/modules/manage_electricity_water_index/manage_electricity_water_index_controller.dart';
import 'package:smart_rent/modules/manage_electricity_water_index/widgets/write_electricity_index_sheet.dart';

class ManageElectricityWaterIndexPage
    extends GetView<ManageElectricityWaterIndexController> {
  const ManageElectricityWaterIndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(title: 'electricity_water_index'.tr),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          _buildTabbar(),
          SizedBox(height: 20.px),
          _buildDropDownSelection(context),
          SizedBox(height: 20.px),
          Expanded(
            child: _buildTabView(context),
          ),
        ],
      ),
    );
  }

  TabBarView _buildTabView(BuildContext context) {
    return TabBarView(
      controller: controller.tabController,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        _buildTableElectricity(context),
        Container(),
      ],
    );
  }

  Container _buildTableElectricity(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.px),
      margin: EdgeInsets.only(left: 16.px, right: 16.px, bottom: 8.px),
      decoration: BoxDecoration(
        border: Border.all(width: 1.px, color: AppColors.secondary80),
        borderRadius: BorderRadius.circular(12.px),
      ),
      child: Column(
        children: [
          _buildAddress(),
          Divider(color: AppColors.secondary80, height: 40.px),
          _buildRowData(
            context,
            value: [
              'room_number'.tr,
              'old_number'.tr,
              'new_number'.tr,
              'usage'.tr,
            ],
            textStyle: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.secondary40,
            ),
          ),
          Expanded(
            child: KeepAliveWrapper(
              wantKeepAlive: true,
              child: RefreshIndicator(
                onRefresh: () => Future.delayed(const Duration(seconds: 1)),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  padding: EdgeInsets.symmetric(vertical: 16.px),
                  itemBuilder: (context, index) =>
                      Divider(color: AppColors.secondary80, height: 40.px),
                  separatorBuilder: (context, index) => _buildRowData(
                    context,
                    value: [1, 150, () {}, ''],
                    textStyle: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.secondary20,
                    ),
                  ),
                  itemCount: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Row _buildAddress() {
    return Row(
      children: [
        const Icon(
          Icons.location_on_outlined,
          color: AppColors.secondary60,
        ),
        SizedBox(width: 8.px),
        Expanded(
          child: Text.rich(
            style: TextStyle(
              fontSize: 16.sp,
              color: AppColors.secondary20,
              fontWeight: FontWeight.w600,
            ),
            const TextSpan(
              text: 'Số 9 Nguyễn Văn Huyên, Dịch Vọng, Cầu Giấy, Hà Nội',
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRowData(
    BuildContext context, {
    required List<dynamic> value,
    required TextStyle textStyle,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.px),
      child: Row(
        children: value.mapIndexed((index, e) {
          if (e is String) {
            String t = e.toString().trim();
            TextAlign? align;
            if (index == 0) align = TextAlign.start;
            if (index == value.length - 1) align = TextAlign.end;
            if (t.isEmpty) t = '--';
            return Expanded(
              child: Text(
                t,
                style: textStyle,
                textAlign: align,
              ),
            );
          } else if (e is Function) {
            return Expanded(
              child: InkWell(
                borderRadius: BorderRadius.circular(8.px),
                onTap: () {
                  Get.bottomSheet(
                    isScrollControlled: true,
                    isDismissible: true,
                    const WriteElectricityIndexSheet(),
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(8.px),
                  decoration: BoxDecoration(
                    color: AppColors.primary98,
                    borderRadius: BorderRadius.circular(8.px),
                  ),
                  child: Text(
                    'write'.tr,
                    style: textStyle.copyWith(color: AppColors.primary40),
                  ),
                ),
              ),
            );
          } else {
            return Expanded(
              child: Text(
                e.toString(),
                style: textStyle,
              ),
            );
          }
        }).toList(),
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
                              controller.periodSelected.value,
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
                            if (controller.periodSelected.value ==
                                period.toPediod)
                              const Icon(Icons.check,
                                  color: AppColors.primary40),
                          ],
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      controller.periodSelected.value = value!.toPediod;
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
          child: ListView.builder(
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
