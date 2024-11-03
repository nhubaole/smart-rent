import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_rent/core/config/app_colors.dart';

class AlertSnackbar {
  static void hideSnackbar() {
    if (Get.isDialogOpen == false) return;
    if (Get.isDialogOpen == true) Get.back();
  }

  static Future<void> show({
    required String title,
    required String message,
    required bool isError,
    Color? backgroundColor,
    Color? textColor = AppColors.white,
  }) async {
    if (Get.isSnackbarOpen == true) Get.back();
    Get.snackbar(
      title,
      message,
      backgroundColor: backgroundColor ??=
          isError ? AppColors.error : AppColors.success,
      colorText: Colors.white,
    );
  }
}
