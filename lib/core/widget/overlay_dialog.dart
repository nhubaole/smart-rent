import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_rent/core/config/app_colors.dart';

class OverlayDialog extends StatelessWidget {
  final String message;
  const OverlayDialog({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            const CircularProgressIndicator(
              color: AppColors.primary60,
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              message,
              style: const TextStyle(color: AppColors.primary60),
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
    required String message,
  }) async {
    if (Get.isDialogOpen == true) Get.back();
    Get.dialog(
      PopScope(
        canPop: true,
        child: OverlayDialog(message: message),
      ),
      barrierDismissible: false,
    );
  }
}
