import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';

class OverlayLoading extends StatelessWidget {
  final String? message;
  final bool canPop;

  const OverlayLoading({super.key, this.message, required this.canPop});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: canPop,
      child: Dialog(
        backgroundColor: AppColors.transparent,
        elevation: 0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.grey40),
            ),
            SizedBox(height: 16.px),
            Text(
              message ?? 'please_wait_process'.tr,
              style: const TextStyle(color: AppColors.white),
            ),
          ],
        ),
      ),
    );
  }

  static void hide() {
    if (Get.isDialogOpen == false) return;
    if (Get.isDialogOpen == true) Get.back();
  }

  static Future<void> show({
    String? title,
    bool? canPop,
  }) async {
    if (Get.isSnackbarOpen == true) Get.back();
    Get.dialog(
      OverlayLoading(
        message: title,
        canPop: canPop ?? false,
      ),
    );
  }
}
