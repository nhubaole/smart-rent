import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/core/widget/outline_text_filed_widget.dart';
import 'package:smart_rent/modules/contract_creation/contract_creation_controller.dart';

class ContractCreationPartLandlord extends GetView<ContractCreationController> {
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
              textEditingController: TextEditingController(text: "Nguyễn Hoàng Khang"),
              onValidateString: 'Enter',
              textLabel: 'full_name'.tr,
            ),
            SizedBox(height: 16.px),
            Row(
              children: [
                Expanded(
                  child: OutlineTextFiledWidget(
                    maxlines: 1,
                    textEditingController: TextEditingController(text: "12/10/2003"),
                    onValidateString: 'Enter',
                    textLabel: 'date_of_birth'.tr,
                    suffixIcon: const Icon(Icons.calendar_month_outlined),
                    onTap: () {},
                    readOnly: true,
                  ),
                ),
                SizedBox(width: 16.px),
                Expanded(
                  child: OutlineTextFiledWidget(
                    maxlines: 1,
                    textEditingController: TextEditingController(text: "0823306992"),
                    onValidateString: 'Enter',
                    textLabel: "Số điện thoại",
                    hintText: '...',
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.px),
            OutlineTextFiledWidget(
              textEditingController: TextEditingController(text: "97 đường số 11, phường Trường Thọ, quận Thủ Đức, TP HCM"),
              onValidateString: 'Enter',
              textLabel: 'registered_address'.tr,
            ),
            SizedBox(height: 16.px),
            OutlineTextFiledWidget(
              textEditingController: TextEditingController(text: "079304032010"),
              onValidateString: 'Enter',
              textLabel: 'id_card_number'.tr,
              hintText: '06/09/2022',
            ),
            SizedBox(height: 16.px),
            Row(
              children: [
                Expanded(
                  child: OutlineTextFiledWidget(
                    maxlines: 1,
                    textEditingController: TextEditingController(text: "06/09/2022"),
                    onValidateString: 'Enter',
                    textLabel: 'issue_date'.tr,
                    hintText: '',
                    suffixIcon: const Icon(Icons.calendar_month_outlined),
                    onTap: () {},
                    readOnly: true,
                  ),
                ),
                SizedBox(width: 16.px),
                Expanded(
                  child: OutlineTextFiledWidget(
                    maxlines: 1,
                    textEditingController: TextEditingController(text: "Cục cảnh sát quản lý hành chính và trật tự xã hội"),
                    onValidateString: 'Enter',
                    textLabel: 'issue_place'.tr,
                    hintText: '...',
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
