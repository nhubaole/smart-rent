
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/core/helper/number_formatter.dart';
import 'package:smart_rent/core/widget/outline_text_filed_widget.dart';
import 'package:smart_rent/modules/contract_creation/contract_creation_controller.dart';

class ContractCreationPartRoomInfo extends GetView<ContractCreationController> {
  const ContractCreationPartRoomInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.only(
            right: 16.px,
            left: 16.px,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10.px),
      child: Column(
        children: [
          _buildHeader(),
          SizedBox(height: 16.px),
          OutlineTextFiledWidget(
            textEditingController: controller.rentalAddressController,
            onValidateString: 'Enter',
            textLabel: 'rental_address'.tr,
          ),
          SizedBox(height: 16.px),
          OutlineTextFiledWidget(
            textEditingController: controller.electricityFeeController,
            onValidateString: 'Enter',
            textLabel: 'electricity_fee'.tr,
            hintText: 'Nhập tiền điện',
            suffixUnit: '| ${controller.electricityMethod.value}',
            textInputType: TextInputType.number,
            inputFormatters: [NumberFormatter()],
          ),
          SizedBox(height: 16.px),
          OutlineTextFiledWidget(
            textEditingController: controller.waterFeeController,
            onValidateString: 'Enter',
            textLabel: 'water_fee'.tr,
            hintText: 'Nhập tiền nước',
            suffixUnit: '| ${controller.waterMethod.value}',
            inputFormatters: [NumberFormatter()],
            textInputType: TextInputType.number,
          ),
          SizedBox(height: 16.px),
          OutlineTextFiledWidget(
            textEditingController: controller.internetFeeController,
            onValidateString: 'Enter',
            textLabel: 'internet_fee'.tr,
            hintText: 'Nhập tiền internet',
            suffixUnit: '| ₫',
            inputFormatters: [NumberFormatter()],
            textInputType: TextInputType.number,
          ),
          SizedBox(height: 16.px),
          OutlineTextFiledWidget(
            textEditingController: controller.parkingFeeController,
            onValidateString: 'Enter',
            textLabel: 'PHÍ GIỮ XE',
            hintText: 'Nhập phí giữ xe',
            suffixUnit: '| ₫',
            inputFormatters: [NumberFormatter()],
            textInputType: TextInputType.number,
          ),
          SizedBox(height: 16.px),
          OutlineTextFiledWidget(
            textEditingController: TextEditingController(),
            onValidateString: 'Enter',
            textLabel: 'monthly_payment_date'.tr,
            hintText: 'Nhập ngày thanh toán hàng tháng',
            textInputType: TextInputType.number,
          ),
        ],
      ),
    );
  }

  Align _buildHeader() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        'rental_details'.tr,
        style: TextStyle(
          color: AppColors.primary40,
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
