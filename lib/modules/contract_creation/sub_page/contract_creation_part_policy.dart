import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/core/widget/outline_text_filed_widget.dart';

class ContractCreationPartPolicy extends StatelessWidget {
  const ContractCreationPartPolicy({super.key});

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
          _buildPrivateForPartner(
            partner: 'landlord_responsibility'.tr,
            onChanged: (value) {},
            value: true,
            textEditingController: TextEditingController(),
            onValidate: (value) {
              return null;
            },
          ),
          SizedBox(height: 16.px),
          _buildPrivateForPartner(
            partner: 'tenant_responsibility'.tr,
            onChanged: (value) {},
            value: true,
            textEditingController: TextEditingController(),
            onValidate: (value) {
              return null;
            },
          ),
          SizedBox(height: 16.px),
          _buildPrivateForPartner(
            partner: 'joint_responsibility'.tr,
            onChanged: (value) {},
            value: true,
            textEditingController: TextEditingController(),
            onValidate: (value) {
              return null;
            },
          ),
          SizedBox(height: 16.px),
        ],
      ),
    );
  }

  Column _buildPrivateForPartner({
    required String partner,
    required Function(bool?)? onChanged,
    required bool value,
    required TextEditingController textEditingController,
    required String? Function(String?)? onValidate,
    int minlines = 5,
  }) {
    return Column(
      children: [
        _buildResponsibilityPartner(partner),
        SizedBox(height: 4.px),
        InkWell(
          borderRadius: BorderRadius.circular(20.px),
          onTap: onChanged != null
              ? () {
                  onChanged(!value);
                }
              : null,
          child: Row(
            children: [
              Checkbox(
                value: value,
                onChanged: onChanged,
                activeColor: AppColors.primary40,
              ),
              Text(
                'use_system_template'.tr,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.normal,
                  color: AppColors.secondary20,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 4.px),
        OutlineTextFiledWidget(
          textEditingController: textEditingController,
          onValidate: onValidate,
          minlines: minlines,
        ),
      ],
    );
  }

  Align _buildResponsibilityPartner(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16.sp,
          color: AppColors.secondary40,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Align _buildHeader() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        'responsibilities'.tr,
        style: TextStyle(
          color: AppColors.primary40,
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
