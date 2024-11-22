import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/core/routes/app_routes.dart';
import 'package:smart_rent/core/widget/button_outline.dart';
import 'package:smart_rent/core/widget/custom_app_bar.dart';
import 'package:smart_rent/core/widget/scaffold_widget.dart';
import 'package:smart_rent/modules/contract_info/contract_info_controller.dart';

class ContractInfoPage extends GetView<ContractInfoController> {
  const ContractInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(
        title: 'contract_information'.tr,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.px),
        child: Column(
          children: [
            _buildInfoItem(
              title: 'contract_code'.tr,
              value: 'value',
              padding: EdgeInsets.symmetric(vertical: 16.px),
            ),
            const Divider(
              color: AppColors.secondary80,
              thickness: 0.5,
              height: 0,
            ),
            _buildInfoItem(
              title: 'contract_type'.tr,
              value: 'value',
              padding: EdgeInsets.symmetric(vertical: 16.px),
            ),
            const Divider(
              color: AppColors.secondary80,
              thickness: 0.5,
              height: 0,
            ),
            _buildInfoItem(
              title: 'address'.tr,
              value: '97 đường số 11, phường Trường Thọ, TP Thủ Đức, TP HCM',
              padding: EdgeInsets.symmetric(vertical: 16.px),
            ),
            const Divider(
              color: AppColors.secondary80,
              thickness: 0.5,
              height: 0,
            ),
            _buildInfoParty(
                'party_a'.tr, ['Nguyễn Phương Phương', '14:05:03 10/12/2023']),
            const Divider(
              color: AppColors.secondary80,
              thickness: 0.5,
              height: 0,
            ),
            _buildInfoParty(
                'party_b'.tr, ['Nguyễn Phương Phương', '14:05:03 10/12/2023']),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.px, vertical: 16.px),
        child: Row(
          children: [
            Expanded(
              child: ButtonOutline(
                borderWidth: 1.5,
                onPressed: () {
                  Get.toNamed(AppRoutes.contractDetail);
                },
                icon: const Icon(
                  Icons.mode_edit_sharp,
                  size: 20,
                  color: AppColors.primary60,
                ),
                text: Text(
                  'sign_contract'.tr,
                  style: const TextStyle(
                    color: AppColors.primary60,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                borderColor: AppColors.primary60,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(
      {required String title,
      required String value,
      EdgeInsets padding = EdgeInsets.zero}) {
    return Container(
      padding: padding,
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16.sp,
                color: AppColors.secondary40,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 16.sp,
                color: AppColors.black,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.end,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoParty(String title, List<String> value) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.px),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16.sp,
              color: AppColors.secondary40,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 24.px),
          Column(
            children: [
              _buildInfoItem(title: 'signer_name_a'.tr, value: value[0]),
              SizedBox(height: 16.px),
              _buildInfoItem(title: 'signer_name_b'.tr, value: value[1])
            ],
          ),
        ],
      ),
    );
  }
}
