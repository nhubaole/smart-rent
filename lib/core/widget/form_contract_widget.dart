import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';

class FormContractWidget extends StatelessWidget {
  const FormContractWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        right: 8.px,
        left: 8.px,
        top: 8.px,
        bottom: 32.px,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8.px),
        border: Border.all(width: 1, color: AppColors.secondary80),
      ),
      // child: ,
    );
  }
}
