import 'package:flutter/material.dart';
import 'package:smart_rent/core/config/app_colors.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        backgroundColor: AppColors.primary95,
        strokeWidth: 2.5,
        strokeAlign: 2.0,
        color: AppColors.primary60,
        strokeCap: StrokeCap.round,
        valueColor: AlwaysStoppedAnimation(AppColors.primary40),
      ),
    );
  }
}
