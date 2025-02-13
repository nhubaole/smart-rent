import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/core/routes/app_routes.dart';
import 'package:smart_rent/core/widget/custom_app_bar.dart';
import 'package:smart_rent/core/widget/scaffold_widget.dart';
import 'package:smart_rent/core/widget/solid_button_widget.dart';
import 'package:smart_rent/modules/landlord_bill_edit/landlord_bill_edit_controller.dart';

class LandlordBillEditPage extends GetView<LandlordBillEditController> {
  const LandlordBillEditPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      appBar: CustomAppBar(title: 'edit_invoice'.tr),
      body: SingleChildScrollView(
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
      ),
      bottomNavigationBar: SolidButtonWidget(
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
            values: ['200,000 VND'],
          ),
          Divider(
            color: AppColors.secondary80.withOpacity(0.5),
            thickness: 1,
            height: 16.px,
          ),
          _buildBillInfoItem(
            title: 'electricity'.tr,
            values: [
              'số cũ: 234 - số mới: 254',
              '3,000đ',
              'x20',
              '350,000đ',
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
              'số cũ: 234 - số mới: 254',
              '3,000đ',
              'x20',
              '350,000đ',
            ],
          ),
          Divider(
            color: AppColors.secondary80.withOpacity(0.5),
            thickness: 1,
            height: 16.px,
          ),
          _buildBillInfoItem(
            title: 'internet'.tr,
            values: ['1,300,000 VND'],
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
