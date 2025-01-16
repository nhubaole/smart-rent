import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/core/enums/bill_status.dart';
import 'package:smart_rent/core/enums/loading_type.dart';
import 'package:smart_rent/core/extension/int_extension.dart';
import 'package:smart_rent/core/routes/app_routes.dart';
import 'package:smart_rent/core/widget/custom_app_bar.dart';
import 'package:smart_rent/core/widget/error_widget.dart';
import 'package:smart_rent/core/widget/loading_widget.dart';
import 'package:smart_rent/core/widget/outline_button_widget.dart';
import 'package:smart_rent/core/widget/scaffold_widget.dart';
import 'package:smart_rent/modules/landlord_bill_info/landlord_bill_info_controller.dart';

class LandlordBillInfoPage extends GetView<LandlordBillInfoController> {
  const LandlordBillInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      appBar: CustomAppBar(title: 'bill_information'.tr),
      body: Obx(() => _buildListByStatus(context)),
      bottomNavigationBar: OutlineButtonWidget(
        height: 50.px,
        margin: EdgeInsets.symmetric(horizontal: 16.px, vertical: 4.px),
        text: 'edit_invoice'.tr,
        onTap: () => Get.toNamed(AppRoutes.landlordBillEdit),
        leading: const Icon(
          Icons.edit,
          color: AppColors.primary60,
        ),
      ),
    );
  }

  Widget _buildListByStatus(BuildContext context) {
    switch (controller.isLoadingData.value) {
      case LoadingType.INIT:
      case LoadingType.LOADING:
        return const LoadingWidget();
      case LoadingType.LOADED:
        return _buildBilling(context);
      case LoadingType.ERROR:
        return const ErrorCustomWidget(
          expandToCanPullToRefresh: true,
        );
    }
  }

  Padding _buildBilling(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.px),
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  _buildTimeCreation(),
                  SizedBox(height: 16.px),
                  _buildStatus(),
                  SizedBox(height: 16.px),
                  OutlineButtonWidget(
                    leading: const Icon(
                      Icons.notifications,
                      color: AppColors.primary60,
                    ),
                    text: 'reminder_payment'.tr,
                    onTap: () {},
                  ),
                  SizedBox(height: 16.px),
                ],
              ),
            ),
          ];
        },
        scrollDirection: Axis.vertical,
        physics: const ClampingScrollPhysics(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderBillInfo('bill_information'.tr),
            SizedBox(height: 8.px),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildBillInfo(),
                    SizedBox(height: 16.px),
                    _buildTotalAmount(),
                    SizedBox(height: 16.px),
                    Divider(
                      color: AppColors.secondary80.withOpacity(0.5),
                      thickness: 1,
                      height: 16.px,
                    ),
                    SizedBox(height: 16.px),
                    _buildHeaderBillInfo('payment_information'.tr),
                    SizedBox(height: 16.px),
                    _buildBillPayment(),
                    SizedBox(height: 16.px),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _buildBillPayment() {
    return Container(
      padding: EdgeInsets.all(16.px),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8.px),
        border: Border.all(
          width: 0.5,
          color: AppColors.secondary60,
        ),
      ),
      child: Column(
        children: [
          _buildBillInfoItem(
            title: 'name'.tr,
            values: [controller.billByIdModel!.info?.tenantName ?? '--'],
          ),
          Divider(
            color: AppColors.secondary80.withOpacity(0.5),
            thickness: 1,
            height: 16.px,
          ),
          _buildBillInfoItem(
            title: 'phone_number'.tr,
            values: [controller.billByIdModel!.info?.phoneNumber ?? '--'],
          ),
          Divider(
            color: AppColors.secondary80.withOpacity(0.5),
            thickness: 1,
            height: 16.px,
          ),
          _buildBillInfoItem(
            title: 'room_number'.tr,
            values: [
              '${controller.billByIdModel!.info?.roomNumber}'
            ],
          ),
          Divider(
            color: AppColors.secondary80.withOpacity(0.5),
            thickness: 1,
            height: 16.px,
          ),
          _buildBillInfoItem(
            title: 'address'.tr,
            values: [
              controller.billByIdModel!.info?.address ?? '--',
            ],
            maxLines: 5,
          ),
          Divider(
            color: AppColors.secondary80.withOpacity(0.5),
            thickness: 1,
            height: 16.px,
          ),
          _buildBillInfoItem(
            title: 'period'.tr,
            values: [
              'Tháng ${controller.billByIdModel!.info?.month} - ${controller.billByIdModel!.info?.year}'
            ],
          ),
        ],
      ),
    );
  }

  Row _buildTotalAmount() {
    final TextStyle textStyle = TextStyle(
      fontSize: 18.sp,
      color: AppColors.secondary20,
      fontWeight: FontWeight.bold,
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('total_amount'.tr, style: textStyle),
        Text(
          controller.billByIdModel!.totalAmount
                  ?.toStringTotalthis(symbol: 'đ') ??
              '',
          style: textStyle.copyWith(
            color: AppColors.primary40,
          ),
        ),
      ],
    );
  }

  Container _buildBillInfo() {
    return Container(
      padding: EdgeInsets.all(16.px),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8.px),
        border: Border.all(
          width: 0.5,
          color: AppColors.secondary60,
        ),
      ),
      child: Column(
        children: [
          _buildBillInfoItem(
            title: 'Mã hóa đơn'.tr,
            values: [
              controller.billByIdModel!.code ?? '--',
            ],
          ),
          Divider(
            color: AppColors.secondary80.withOpacity(0.5),
            thickness: 1,
            height: 16.px,
          ),
          _buildBillInfoItem(
            title: 'rent_fee'.tr,
            values: [
              controller.billByIdModel!.roomPrice
                      ?.toStringTotalthis(symbol: 'đ') ??
                  '--'
            ],
          ),
          Divider(
            color: AppColors.secondary80.withOpacity(0.5),
            thickness: 1,
            height: 16.px,
          ),
          _buildBillInfoItem(
            title: 'electricity'.tr,
            values: [
              'số cũ: ${controller.billByIdModel?.oldElectricityIndex} - số mới: ${controller.billByIdModel?.newElectricityIndex}',
              (controller.billByIdModel!.electricityCost
                      ?.toStringTotalthis(symbol: 'đ') ??
                  '--'),
              'x${controller.billByIdModel!.electricityCost}',
              (controller.calElectricCost.toStringTotalthis(symbol: 'đ')),
            ],
          ),
          Divider(
            color: AppColors.secondary80.withOpacity(0.5),
            thickness: 1,
            height: 16.px,
          ),
          _buildBillInfoItem(
            title: 'water'.tr,
            // values: [
            //   'số cũ: 234 - số mới: 254',
            //   '3,000đ',
            //   'x20',
            //   '350,000đ',
            // ],

            values: [
              'số cũ: ${controller.billByIdModel?.oldWaterIndex} - số mới: ${controller.billByIdModel?.newWaterIndex}',
              (controller.billByIdModel!.waterCost
                      ?.toStringTotalthis(symbol: 'đ') ??
                  '--'),
              'x${controller.billByIdModel!.waterCost}',
              (controller.calWaterCost.toStringTotalthis(symbol: 'đ')),
            ],
          ),
          Divider(
            color: AppColors.secondary80.withOpacity(0.5),
            thickness: 1,
            height: 16.px,
          ),
          _buildBillInfoItem(
            title: 'internet'.tr,
            values: [
              controller.billByIdModel!.internetCost
                      ?.toStringTotalthis(symbol: 'đ') ??
                  ''
            ],
          ),
          Divider(
            color: AppColors.secondary80.withOpacity(0.5),
            thickness: 1,
            height: 16.px,
          ),
          _buildBillInfoItem(
            title: 'parking_fee'.tr,
            values: [
              controller.billByIdModel!.parkingFee
                      ?.toStringTotalthis(symbol: 'đ') ??
                  ''
            ],
          ),
          Divider(
            color: AppColors.secondary80.withOpacity(0.5),
            thickness: 1,
            height: 16.px,
          ),
          _buildBillInfoItem(
            title: 'Phí phát sinh'.tr,
            note: 'Ghi chú: Tiền đổ rác',
            values: [
              controller.billByIdModel!.parkingFee
                      ?.toStringTotalthis(symbol: 'đ') ??
                  ''
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBillInfoItem({
    required String title,
    String? note,
    required List<String> values,
    int maxLines = 3,
  }) {
    final TextStyle titleStyle = TextStyle(
      fontSize: 16.sp,
      color: AppColors.secondary40,
      fontWeight: FontWeight.w500,
    );
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.px),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: titleStyle,
                ),
                if (note != null)
                  Text(
                    '${'note'.tr}: $note',
                    style: titleStyle.copyWith(
                      color: AppColors.secondary40,
                      fontWeight: FontWeight.w300,
                      fontSize: 14.sp,
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: values
                  .map(
                    (e) => Text(
                      e,
                      style: titleStyle.copyWith(
                        color: AppColors.secondary20,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: maxLines,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.end,
                    ),
                  )
                  .toList(),
            ),
          )
        ],
      ),
    );
  }

  Align _buildHeaderBillInfo(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.secondary20,
        ),
        textAlign: TextAlign.start,
      ),
    );
  }

  Container _buildStatus() {
    BillStatus status = BillStatus.unknown;
    if (controller.billByIdModel!.status == -1) {
      status = BillStatus.not_yet_created;
    } else if (controller.billByIdModel!.status == 0) {
      status = BillStatus.unpaid;
    } else if (controller.billByIdModel!.status == 1) {
      status = BillStatus.pending;
    } else if (controller.billByIdModel!.status == 2) {
      status = BillStatus.paid;
    }
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: 1.h,
        horizontal: 2.h,
      ),
      decoration: BoxDecoration(
        color: status.colorContent.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8.px),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon(status.icon, color: status.colorContent),
          SizedBox(width: 1.w),
          Text(
            status.value,
            style: TextStyle(
              color: status.colorContent,
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeCreation() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text.rich(
        TextSpan(
          style: TextStyle(
            fontSize: 16.sp,
            color: AppColors.secondary40,
          ),
          children: [
            TextSpan(
              text: 'creation_time'.tr,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
            const TextSpan(text: ' '),
            const TextSpan(
              text: '13:49 17/09/2023',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
