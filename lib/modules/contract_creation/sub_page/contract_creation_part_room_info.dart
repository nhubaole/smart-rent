
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/core/helper/number_formatter.dart';
import 'package:smart_rent/core/widget/outline_text_filed_widget.dart';

class ContractCreationPartRoomInfo extends StatelessWidget {
  const ContractCreationPartRoomInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.only(
            right: 16.px,
            left: 16.px,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10.px),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'rental_details'.tr,
                style: TextStyle(
                  color: AppColors.primary40,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: 16.px),
            OutlineTextFiledWidget(
              textEditingController: TextEditingController(),
              onValidateString: 'Enter',
              textLabel: 'rental_address'.tr,
              hintText: 'Nguyen Van A',
            ),
            SizedBox(height: 16.px),
            OutlineTextFiledWidget(
              textEditingController: TextEditingController(),
              onValidateString: 'Enter',
              textLabel: 'electricity_fee'.tr,
              hintText: 'Nguyen Van A',
              suffixUnit: '| ₫/kwh',
              textInputType: TextInputType.number,
              inputFormatters: [NumberFormatter()],
            ),
            SizedBox(height: 16.px),
            OutlineTextFiledWidget(
              textEditingController: TextEditingController(),
              onValidateString: 'Enter',
              textLabel: 'water_fee'.tr,
              hintText: 'Nguyen Van A',
              suffixUnit: '| ₫/người',
              inputFormatters: [NumberFormatter()],
              textInputType: TextInputType.number,
            ),
            SizedBox(height: 16.px),
            OutlineTextFiledWidget(
              textEditingController: TextEditingController(),
              onValidateString: 'Enter',
              textLabel: 'internet_fee'.tr,
              hintText: 'Nguyen Van A',
              suffixUnit: '| ₫',
              inputFormatters: [NumberFormatter()],
              textInputType: TextInputType.number,
            ),
            SizedBox(height: 16.px),
            OutlineTextFiledWidget(
              textEditingController: TextEditingController(),
              onValidateString: 'Enter',
              textLabel: 'parking_fee'.tr,
              hintText: 'Nguyen Van A',
              suffixUnit: '| ₫',
              inputFormatters: [NumberFormatter()],
              textInputType: TextInputType.number,
            ),
            SizedBox(height: 16.px),
            OutlineTextFiledWidget(
              textEditingController: TextEditingController(),
              onValidateString: 'Enter',
              textLabel: 'monthly_payment_date'.tr,
              hintText: 'Nguyen Van A',
              textInputType: TextInputType.number,
            ),
          ],
        ),
      ),
    );
  }
}
