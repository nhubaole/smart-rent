import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/core/enums/request_room_status.dart';
import 'package:smart_rent/core/widget/custom_app_bar.dart';
import 'package:smart_rent/core/widget/scaffold_widget.dart';
import 'package:smart_rent/modules/bill_info/bill_info_controller.dart';

class BillInfoPage extends GetView<BillInfoController> {
  const BillInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      appBar: CustomAppBar(title: 'bill_information'.tr),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.px),
          child: Column(
            children: [
              _buildTimeCreation(),
              SizedBox(height: 16.px),
              _buildStatus(),
              SizedBox(height: 16.px),
              _buildHeaderBillInfo('bill_information'.tr),
              SizedBox(height: 16.px),
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
              _buildButtonSubmit(),
              SizedBox(height: 16.px),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildButtonSubmit() {
    return Row(
      children: [
        Expanded(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              splashColor: AppColors.primary60.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20.px),
              onTap: () {
                print('object');
              },
              child: Container(
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.primary60,
                  borderRadius: BorderRadius.circular(20.px),
                  border: Border.all(width: 1, color: AppColors.primary60),
                ),
                child: Text(
                  'payment'.tr,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
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
            values: ['LÊ BẢO NHƯ'],
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
            values: ['HD2220'],
          ),
          Divider(
            color: AppColors.secondary80.withOpacity(0.5),
            thickness: 1,
            height: 16.px,
          ),
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
          Divider(
            color: AppColors.secondary80.withOpacity(0.5),
            thickness: 1,
            height: 16.px,
          ),
          _buildBillInfoItem(
            title: 'additional_fee'.tr,
            note: 'Tiền đổ rác',
            values: ['1,300,000 VND'],
          ),
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
    const status = RequestRoomStatus.pending;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: 1.h,
        horizontal: 2.h,
      ),
      decoration: BoxDecoration(
        color: RequestRoomStatus.pending.colorBackground,
        borderRadius: BorderRadius.circular(8.px),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(status.icon, color: status.colorContent),
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
