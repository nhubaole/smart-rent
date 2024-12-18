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
    bool? isError = false,
    Duration duration = const Duration(milliseconds: 1000),
    Color? backgroundColor,
    Color? textColor = AppColors.white,
    VoidCallback? onRetry,
    String? textBtn,
  }) async {
    if (Get.isSnackbarOpen == true) Get.back();
    Get.snackbar(
      mainButton: onRetry != null ? _buildRetryButton(onRetry, textBtn) : null,
      duration: duration,
      title,
      message,
      backgroundColor: backgroundColor ??=
          isError! ? AppColors.error : AppColors.green20,
      colorText: Colors.white,
    );
  }

  static _buildRetryButton(VoidCallback? onRetry, String? textBtn) {
    return TextButton(
      onPressed: onRetry!,
      style: ButtonStyle(
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        backgroundColor: WidgetStateProperty.all<Color>(
          AppColors.primary40,
        ),
        padding: WidgetStateProperty.all<EdgeInsets>(
          const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
        ),
      ),
      child: Text(
        textBtn ?? 'Thử lại',
        style: TextStyle(
          color: AppColors.white,
        ),
      ),
    );
  }
}
