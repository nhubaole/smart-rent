import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/core/widget/outline_text_filed_widget.dart';

class ContractCreationPartLandlord extends StatelessWidget {
  const ContractCreationPartLandlord({super.key});

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
                'landlord_information'.tr,
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
              textLabel: 'full_name'.tr,
              hintText: 'Nguyen Van A',
            ),
            SizedBox(height: 16.px),
            Row(
              children: [
                Expanded(
                  child: OutlineTextFiledWidget(
                    maxlines: 1,
                    textEditingController: TextEditingController(),
                    onValidateString: 'Enter',
                    textLabel: 'date_of_birth'.tr,
                    hintText: 'Nguyen Van A',
                    suffixIcon: const Icon(Icons.calendar_month_outlined),
                    onTap: () {},
                    readOnly: true,
                  ),
                ),
                SizedBox(width: 16.px),
                Expanded(
                  child: OutlineTextFiledWidget(
                    maxlines: 1,
                    textEditingController: TextEditingController(),
                    onValidateString: 'Enter',
                    textLabel: 'date_of_birth'.tr,
                    hintText: '...',
                    textInputType: const TextInputType.numberWithOptions(
                      decimal: true,
                      signed: true,
                    ),
                    prefixIcon: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.px),
                        child: const Text('+84'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.px),
            OutlineTextFiledWidget(
              textEditingController: TextEditingController(),
              onValidateString: 'Enter',
              textLabel: 'registered_address'.tr,
              hintText: 'Nguyen Van A',
            ),
            SizedBox(height: 16.px),
            OutlineTextFiledWidget(
              textEditingController: TextEditingController(),
              onValidateString: 'Enter',
              textLabel: 'issue_date'.tr,
              hintText: 'Nguyen Van A',
            ),
            SizedBox(height: 16.px),
            Row(
              children: [
                Expanded(
                  child: OutlineTextFiledWidget(
                    maxlines: 1,
                    textEditingController: TextEditingController(),
                    onValidateString: 'Enter',
                    textLabel: 'issue_date'.tr,
                    hintText: 'Nguyen Van A',
                    suffixIcon: const Icon(Icons.calendar_month_outlined),
                    onTap: () {},
                    readOnly: true,
                  ),
                ),
                SizedBox(width: 16.px),
                Expanded(
                  child: OutlineTextFiledWidget(
                    maxlines: 1,
                    textEditingController: TextEditingController(),
                    onValidateString: 'Enter',
                    textLabel: 'issue_place'.tr,
                    hintText: '...',
                    textInputType: const TextInputType.numberWithOptions(
                      decimal: true,
                      signed: true,
                    ),
                    prefixIcon: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.px),
                        child: const Text('+84'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
