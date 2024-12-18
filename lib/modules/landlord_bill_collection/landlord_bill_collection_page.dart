import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/core/enums/loading_type.dart';
import 'package:smart_rent/core/extension/datetime_extension.dart';
import 'package:smart_rent/core/widget/custom_app_bar.dart';
import 'package:smart_rent/core/widget/error_widget.dart';
import 'package:smart_rent/core/widget/keep_alive_wrapper.dart';
import 'package:smart_rent/core/widget/loading_widget.dart';
import 'package:smart_rent/core/widget/scaffold_widget.dart';
import 'package:smart_rent/core/widget/solid_button_widget.dart';
import 'package:smart_rent/modules/landlord_bill_collection/landlord_bill_collection_controller.dart';
import 'package:smart_rent/modules/landlord_bill_collection/widgets/landlord_bill_collection_item.dart';

class LandlordBillCollectionPage
    extends GetView<LandlordBillCollectionController> {
  const LandlordBillCollectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(title: 'bill_collection'.tr),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 24.px),
          _buildRowPeriodSelection(context),
          SizedBox(height: 16.px),
          _buildRowSelectionMode(),
          Expanded(
            child: Obx(() => _buildListByStatus()),
          ),
          SizedBox(height: 8.px),
        ],
      ),
      bottomNavigationBar: Obx(
        () => controller.selectedBills.isNotEmpty
            ? SolidButtonWidget(
                height: 50.px,
                margin: EdgeInsets.symmetric(horizontal: 16.px, vertical: 4.px),
                text: 'create_bill'.tr,
                onTap: controller.onCreateMultiBills,
              )
            : const SizedBox.shrink(),
      ),
    );
  }

  Widget _buildListByStatus() {
    switch (controller.isLoadingData.value) {
      case LoadingType.INIT:
      case LoadingType.LOADING:
        return const LoadingWidget();
      case LoadingType.LOADED:
        if (controller.billings.value == null) {
          return const Center(
            child: Text('Không có hóa đơn'),
          );
        }
        return _buildBillCollection();
      case LoadingType.ERROR:
        return const ErrorCustomWidget(
          expandToCanPullToRefresh: true,
        );
    }
  }

  Widget _buildRowSelectionMode() {
    return Obx(
      () => Container(
        padding: EdgeInsets.only(right: 16.px),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            if (!controller.isMultipleSelectionMode.value)
              const Expanded(child: SizedBox()),
            if (controller.isMultipleSelectionMode.value)
              _buildSelectAllButton(onTap: controller.onChangeSelectAll),
            _buildMutilSelectionButton(onTap: controller.onChangeSelectionMode),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectAllButton({required Function(bool?) onTap}) {
    return GestureDetector(
      onTap: () => onTap(null),
      child: Row(
        children: [
          Checkbox(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.px),
            ),
            onChanged: onTap,
            value: controller.isSelectAllMode.value,
            checkColor: AppColors.white,
            activeColor: AppColors.primary40,
          ),
          Text(
            'select_all'.tr,
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.primary40,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMutilSelectionButton({required Function(bool?) onTap}) {
    return GestureDetector(
      onTap: () => onTap(null),
      child: Row(
        children: [
          Checkbox(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.px),
            ),
            onChanged: onTap,
            value: controller.isMultipleSelectionMode.value,
            checkColor: AppColors.white,
            activeColor: AppColors.primary40,
          ),
          Text(
            'select_multiple'.tr,
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.primary40,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Container _buildBillCollection() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.px),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10.px),
        border: Border.all(
          color: AppColors.secondary60.withOpacity(0.5),
          width: 0.5.px,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.secondary90,
            blurRadius: 1.px,
            offset: Offset(0, 2.px),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.px),
        child: Column(
          children: [
            _buildAddress(),
            _buildBills(),
          ],
        ),
      ),
    );
  }

  Widget _buildBills() {
    if (controller.billings.value!.listBill!.isEmpty) {
      return const SizedBox.shrink();
    }
    return KeepAliveWrapper(
      wantKeepAlive: true,
      child: Expanded(
        child: ListView.separated(
          separatorBuilder: (context, index) => Divider(
            color: AppColors.secondary80.withOpacity(0.2),
            thickness: 1,
            height: 8.px,
          ),
          itemCount: controller.billings.value!.listBill!.length,
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          padding: EdgeInsets.symmetric(vertical: 8.px),
          itemBuilder: (context, index) {
            final item = controller.billings.value!.listBill![index];
            return Obx(
              () => LandlordBillCollectionItem(
                isMultipleSelectionMode:
                    controller.isMultipleSelectionMode.value,
                isSelected: controller.isSelectAllMode.value,
                onTap: controller.onSelectItem,
                bill: item,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildAddress() {
    return Container(
      padding:
          EdgeInsets.only(left: 16.px, right: 16.px, top: 16.px, bottom: 8.px),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.secondary80.withOpacity(0.4),
            width: 1.px,
          ),
        ),
      ),
      child: Row(
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
              TextSpan(
                text: controller.billings.value!.address ?? '',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding _buildRowPeriodSelection(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.px),
      child: Row(
        children: [
          Expanded(child: _buildPeriodSelection(context)),
          SizedBox(width: 8.px),
          Expanded(
            child: SolidButtonWidget(
              borderRadius: BorderRadius.circular(100.px),
              padding: EdgeInsets.all(8.px),
              height: 65.px,
              text: 'select'.tr,
              onTap: () {
                controller.fetchBilling();
              },
            ),
          ),
        ],
      ),
    );
  }

  Obx _buildPeriodSelection(BuildContext context) {
    final textStyle = TextStyle(
      fontSize: 16.sp,
      color: AppColors.secondary20,
      fontWeight: FontWeight.w600,
    );
    return Obx(
      () => Container(
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
                    if (controller.periodSelected.value.toPediod ==
                        period.toPediod)
                      const Icon(Icons.check, color: AppColors.primary40),
                  ],
                ),
              );
            }).toList(),
            onChanged: (value) {
              controller.periodSelected.value = value!;
              controller.fetchBilling();
            },
          ),
        ),
      ),
    );
  }
}
