
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';

class ContractCreationPartPreview extends StatelessWidget {
  const ContractCreationPartPreview({super.key});

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
        ],
      ),
    );
  }

  Align _buildHeader() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        'preview_contract_template'.tr,
        style: TextStyle(
          color: AppColors.primary40,
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
