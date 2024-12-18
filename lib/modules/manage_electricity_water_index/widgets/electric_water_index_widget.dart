import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/core/model/billing/billing_list_index_by_landlord_model.dart';

class ElectricWaterIndexWidget extends StatelessWidget {
  final BillingListIndexByLandlordModel billingIndexs;
  final Function(int) onWriteIndex;
  const ElectricWaterIndexWidget({
    super.key,
    required this.billingIndexs,
    required this.onWriteIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.px),
      margin: EdgeInsets.only(left: 16.px, right: 16.px, bottom: 8.px),
      decoration: BoxDecoration(
        border: Border.all(width: 1.px, color: AppColors.secondary80),
        borderRadius: BorderRadius.circular(12.px),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
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
          Column(
            children: billingIndexs.indexInfo
                .mapIndexed(
                  (index, item) => _buildRowData(
                    context,
                    value: [
                      item.roomNumber,
                      item.oldIndex,
                      () => onWriteIndex(index),
                      item.used == null ? '--' : item.used.toString(),
                    ],
                    textStyle: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.secondary20,
                    ),
                  ),
                )
                .toList(),
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
            TextSpan(
              text: billingIndexs.address,
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
                onTap: () => e(),
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
                textAlign: index == value.length - 1 ? TextAlign.center : null,
              ),
            );
          }
        }).toList(),
      ),
    );
  }
}
