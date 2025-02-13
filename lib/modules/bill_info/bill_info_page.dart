import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/core/enums/loading_type.dart';
import 'package:smart_rent/core/enums/request_room_status.dart';
import 'package:smart_rent/core/extension/datetime_extension.dart';
import 'package:smart_rent/core/extension/int_extension.dart';
import 'package:smart_rent/core/widget/custom_app_bar.dart';
import 'package:smart_rent/core/widget/error_widget.dart';
import 'package:smart_rent/core/widget/loading_widget.dart';
import 'package:smart_rent/core/widget/scaffold_widget.dart';
import 'package:smart_rent/core/widget/solid_button_widget.dart';
import 'package:smart_rent/modules/bill_info/bill_info_controller.dart';

class BillInfoPage extends GetView<BillInfoController> {
  const BillInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      appBar: CustomAppBar(title: 'bill_information'.tr),
      body: Obx(() => _buildListByStatus()),
      bottomNavigationBar: Obx(
        () => _buildNavButton(),
      ),
    );
  }

  Widget _buildNavButton() {
    if (controller.isLoadingData.value != LoadingType.LOADED ||
        controller.billByStatusModel?.status == 2) {
      return SizedBox();
    }
    return SolidButtonWidget(
      height: 50.px,
      margin: EdgeInsets.symmetric(horizontal: 16.px, vertical: 4.px),
      text: 'payment'.tr,
      onTap: controller.onNavPaymentDeposit,
    );
  }

  Widget _buildListByStatus() {
    switch (controller.isLoadingData.value) {
      case LoadingType.INIT:
      case LoadingType.LOADING:
        return const LoadingWidget();
      case LoadingType.LOADED:
        return _buildBillInfoPage();
      case LoadingType.ERROR:
        return const ErrorCustomWidget(
          expandToCanPullToRefresh: true,
        );
    }
  }

  Widget _buildBillInfoPage() {
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

  // Row _buildButtonSubmit() {
  //   return Row(
  //     children: [
  //       Expanded(
  //         child: Material(
  //           color: Colors.transparent,
  //           child: InkWell(
  //             splashColor: AppColors.primary60.withOpacity(0.2),
  //             borderRadius: BorderRadius.circular(20.px),
  //             onTap: () {
  //               print('object');
  //             },
  //             child: Container(
  //               height: 50,
  //               alignment: Alignment.center,
  //               decoration: BoxDecoration(
  //                 color: AppColors.primary60,
  //                 borderRadius: BorderRadius.circular(20.px),
  //                 border: Border.all(width: 1, color: AppColors.primary60),
  //               ),
  //               child: Text(
  //                 'payment'.tr,
  //                 style: TextStyle(
  //                   fontSize: 16.sp,
  //                   color: AppColors.white,
  //                   fontWeight: FontWeight.bold,
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

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
            values: [controller.billInfo.value!.info?.tenantName ?? ''],
          ),
          Divider(
            color: AppColors.secondary80.withOpacity(0.5),
            thickness: 1,
            height: 16.px,
          ),
          _buildBillInfoItem(
            title: 'phone_number'.tr,
            values: [controller.billInfo.value!.info?.phoneNumber ?? ''],
          ),
          Divider(
            color: AppColors.secondary80.withOpacity(0.5),
            thickness: 1,
            height: 16.px,
          ),
          _buildBillInfoItem(
            title: 'room_number'.tr,
            values: [
              controller.billInfo.value!.info?.roomNumber.toString() ?? '',
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
              controller.billInfo.value!.info?.address ?? '',
            ],
              maxLines: 5
          ),
          Divider(
            color: AppColors.secondary80.withOpacity(0.5),
            thickness: 1,
            height: 16.px,
          ),
          _buildBillInfoItem(
            title: 'period'.tr,
            values: [
              'Tháng ${controller.billInfo.value!.info?.month ?? ''}/${controller.billInfo.value!.info?.year ?? ''}'
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
          controller.billInfo.value!.totalAmount
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
            title: 'bill_code'.tr,
            values: [controller.billInfo.value!.code ?? ''],
          ),
          Divider(
            color: AppColors.secondary80.withOpacity(0.5),
            thickness: 1,
            height: 16.px,
          ),
          _buildBillInfoItem(
            title: 'rent_fee'.tr,
            values: [
              controller.billInfo.value!.roomPrice
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
            title: 'electricity'.tr,
            values: [
              'số cũ: ${controller.billInfo.value!.oldElectricityIndex} - số mới: ${controller.billInfo.value!.newElectricityIndex}',
              (controller.billInfo.value!.electricityCost
                      ?.toStringTotalthis(symbol: 'đ') ??
                  ''),
              'x${controller.billInfo.value!.newElectricityIndex! - controller.billInfo.value!.oldElectricityIndex!}',
              (((controller.billInfo.value!.electricityCost!) *
                      (controller.billInfo.value!.newElectricityIndex! -
                          controller.billInfo.value!.oldElectricityIndex!))
                  .toStringTotalthis(symbol: 'đ')),
            ],
          ),
          Divider(
            color: AppColors.secondary80.withOpacity(0.5),
            thickness: 1,
            height: 16.px,
          ),
          _buildBillInfoItem(
            title: 'water'.tr,
            values: [
              'số cũ: ${controller.billInfo.value!.oldWaterIndex} - số mới: ${controller.billInfo.value!.newWaterIndex}',
              (controller.billInfo.value!.waterCost
                      ?.toStringTotalthis(symbol: 'đ') ??
                  ''),
              'x${controller.billInfo.value!.newWaterIndex! - controller.billInfo.value!.oldWaterIndex!}',
              (((controller.billInfo.value!.waterCost!) *
                      (controller.billInfo.value!.newWaterIndex! -
                          controller.billInfo.value!.oldWaterIndex!))
                  .toStringTotalthis(symbol: 'đ')),
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
              controller.billInfo.value!.internetCost
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
              controller.billInfo.value!.parkingFee
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
            title: 'additional_fee'.tr,
            note: controller.billInfo.value!.additionNote,
            values: [
              controller.billInfo.value!.additionFee
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
    int? maxLines = 3,
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
    final status = RequestRoomStatusExtension.fromInt(
        controller.billInfo.value!.status! - 1);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: 1.h,
        horizontal: 2.h,
      ),
      decoration: BoxDecoration(
        color: controller.billInfo.value!.status == 0
            ? Colors.red.withOpacity(0.1)
            : AppColors.greenOrigin.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8.px),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(status.icon,
              color: controller.billInfo.value!.status == 0
                  ? Colors.red
                  : AppColors.greenOrigin),
          SizedBox(width: 1.w),
          Text(
            controller.billInfo.value!.status == 0 ? 'unpaid'.tr : 'paid'.tr,
            style: TextStyle(
              color: controller.billInfo.value!.status == 0
                  ? Colors.red
                  : AppColors.greenOrigin,
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
            TextSpan(
              text: controller.billInfo.value!.createdAt?.hhmmDDMMyyyy ?? '',
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
