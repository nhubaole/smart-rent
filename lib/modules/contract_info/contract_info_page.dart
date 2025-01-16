import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/app/app_manager.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/core/extension/datetime_extension.dart';
import 'package:smart_rent/core/widget/custom_app_bar.dart';
import 'package:smart_rent/core/widget/outline_button_widget.dart';
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
              value: controller.contract.code ?? '',
              padding: EdgeInsets.symmetric(vertical: 16.px),
            ),
            const Divider(
              color: AppColors.secondary80,
              thickness: 0.5,
              height: 0,
            ),
            _buildInfoItem(
              title: 'contract_type'.tr,
              value: 'rental_contract'.tr,
              padding: EdgeInsets.symmetric(vertical: 16.px),
            ),
            const Divider(
              color: AppColors.secondary80,
              thickness: 0.5,
              height: 0,
            ),
            _buildInfoItem(
              title: 'address'.tr,
              value: controller.contract.roomAddress ?? '',
              padding: EdgeInsets.symmetric(vertical: 16.px),
            ),
            const Divider(
              color: AppColors.secondary80,
              thickness: 0.5,
              height: 0,
            ),
            _buildInfoParty('party_a'.tr, [
              controller.contract.landlordName ?? '--',
              controller.contract.signatureTimeA?.ddMMyyyy ?? '--',
            ]),
            const Divider(
              color: AppColors.secondary80,
              thickness: 0.5,
              height: 0,
            ),
            _buildInfoParty('party_b'.tr, [
              controller.contract.tenantName ?? '--',
              controller.contract.signatureTimeB?.ddMMyyyy ?? '--',
            ]),
          ],
        ),
      ),
      bottomNavigationBar: _buildButtonSignContract(),
    );
  }

  Widget? _buildButtonSignContract() {
    if (AppManager().currentUser?.role == 1) {
      return OutlineButtonWidget(
        height: 50.px,
        margin: EdgeInsets.only(left: 16.px, right: 16.px, bottom: 16.px),
        padding: EdgeInsets.zero,
        text: 'Xem chi tiết hợp đồng',
        onTap: controller.onNavContractDetail,
      );
    } 
    if (controller.contractType != 0) {
      return OutlineButtonWidget(
        height: 50.px,
        margin: EdgeInsets.only(left: 16.px, right: 16.px, bottom: 16.px),
        padding: EdgeInsets.zero,
        text: 'Xem chi tiết hợp đồng',
        onTap: controller.onNavContractDetail,
      );
    }
    if (controller.contract.signatureTimeB != null) {
      return OutlineButtonWidget(
        height: 50.px,
        margin: EdgeInsets.only(left: 16.px, right: 16.px, bottom: 16.px),
        padding: EdgeInsets.zero,
        onTap: controller.onNavPayment,
        trailing: const Icon(
          Icons.arrow_forward_ios_outlined,
          size: 20,
          color: AppColors.primary60,
        ),
        borderRadius: BorderRadius.circular(100),
        child: Text(
          'Đặt cọc ngay'.tr,
          style: const TextStyle(
            color: AppColors.primary60,
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
      );
    }

    if (controller.showButtonSignContract) {
      return OutlineButtonWidget(
        height: 50.px,
        margin: EdgeInsets.only(left: 16.px, right: 16.px, bottom: 16.px),
        padding: EdgeInsets.zero,
        onTap: controller.onNavContractDetail,
        trailing: const Icon(
          Icons.arrow_forward_ios_outlined,
          size: 20,
          color: AppColors.primary60,
        ),
        borderRadius: BorderRadius.circular(100),
        child: Text(
          'sign_contract'.tr,
          style: const TextStyle(
            color: AppColors.primary60,
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
      );
    }

    return null;
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
              _buildInfoItem(title: 'signing_time_a'.tr, value: value[1])
            ],
          ),
        ],
      ),
    );
  }
}
