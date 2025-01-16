import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/core/enums/loading_type.dart';
import 'package:smart_rent/core/extension/int_extension.dart';
import 'package:smart_rent/core/routes/app_routes.dart';
import 'package:smart_rent/core/widget/custom_app_bar.dart';
import 'package:smart_rent/core/widget/error_widget.dart';
import 'package:smart_rent/core/widget/loading_widget.dart';
import 'package:smart_rent/core/widget/scaffold_widget.dart';
import 'package:smart_rent/core/widget/solid_button_widget.dart';
import 'package:smart_rent/modules/landlord_bill_create/landlord_bill_create_controller.dart';

class LandlordBillCreatePage extends GetView<LandlordBillCreateController> {
  const LandlordBillCreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ScaffoldWidget(
        appBar: CustomAppBar(
            title: 'Tạo hóa đơn tháng ${controller.period.value?.month ?? ''}'),
        body: _buildListByStatus(context),
        bottomNavigationBar: SolidButtonWidget(
          height: 50.px,
          margin: EdgeInsets.symmetric(horizontal: 16.px, vertical: 4.px),
          text: 'Tạo hóa đơn'.tr,
          onTap: () => Get.toNamed(AppRoutes.landlordBillEdit),
          leading: const Icon(
            Icons.edit,
            color: AppColors.primary60,
          ),
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

  SingleChildScrollView _buildBilling(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.only(
          left: 16.px,
          right: 16.px,
          bottom: MediaQuery.of(context).viewInsets.bottom + 10.px),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeaderBillInfo('bill_information'.tr),
          SizedBox(height: 8.px),
          _buildBillInfo(),
          SizedBox(height: 16.px),
          _buildAdditionalFee(),
          SizedBox(height: 16.px),
          _buildTotalAmount(),
          SizedBox(height: 16.px),
          Divider(
            color: AppColors.secondary80.withOpacity(0.5),
            thickness: 1,
            height: 16.px,
          ),
          _buildHeaderBillInfo('payment_information'.tr),
          SizedBox(height: 16.px),
          _buildPaymentInfo(),
          SizedBox(height: 16.px),
        ],
      ),
    );
  }

  Container _buildPaymentInfo() {
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
            values: ['Lê Bảo Như'],
          ),
          Divider(
            color: AppColors.secondary80.withOpacity(0.5),
            thickness: 1,
            height: 16.px,
          ),
          _buildBillInfoItem(
            title: 'phone_number'.tr,
            values: ['0823306992'],
          ),
          Divider(
            color: AppColors.secondary80.withOpacity(0.5),
            thickness: 1,
            height: 16.px,
          ),
          _buildBillInfoItem(
            title: 'room_number'.tr,
            values: [
              '3.11',
            ],
          ),
          Divider(
            color: AppColors.secondary80.withOpacity(0.5),
            thickness: 1,
            height: 16.px,
          ),
          _buildBillInfoItem(
            title: 'room_number'.tr,
            values: [
              '3.11',
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
              '97 đường số 11, phường Trường Thọ, TP Thủ Đức, TP HCM',
            ],
          ),
          Divider(
            color: AppColors.secondary80.withOpacity(0.5),
            thickness: 1,
            height: 16.px,
          ),
          _buildBillInfoItem(
            title: 'period'.tr,
            values: ['Tháng 10/2024'],
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
          '3,560,000đ',
          style: textStyle.copyWith(
            color: AppColors.primary40,
          ),
        ),
      ],
    );
  }

  Row _buildAdditionalFee() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: _buildTextInputFieldAdditionalFee(
            label: 'additional_fee'.tr,
            hint: 'enter_amount'.tr,
          ),
        ),
        SizedBox(width: 16.px),
        Expanded(
          child: _buildTextInputFieldAdditionalFee(
            label: 'noete'.tr,
            hint: 'enter_note'.tr,
          ),
        ),
      ],
    );
  }

  Container _buildTextInputFieldAdditionalFee({
    required String label,
    required String hint,
  }) {
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
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label),
          SizedBox(
            height: 30.px,
            child: TextFormField(
              controller: TextEditingController(),
              decoration: InputDecoration(
                hintText: 'note'.tr,
                hintStyle: TextStyle(
                  fontSize: 16.sp,
                  color: AppColors.secondary40,
                ),
                border: InputBorder.none, // This removes the border
                enabledBorder: InputBorder
                    .none, // Removes the border when the field is enabled
                focusedBorder: InputBorder
                    .none, // Removes the border when the field is focused
                disabledBorder: InputBorder
                    .none, // Removes the border when the field is disabled
                errorBorder: InputBorder.none, // Removes the error border
                focusedErrorBorder:
                    InputBorder.none, // Removes the focused error border
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildBillInfoItem({
    required String title,
    String? note,
    required List<String> values,
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
                      maxLines: 3,
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
            values: ['1,300,000 VND'],
          ),
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
}
