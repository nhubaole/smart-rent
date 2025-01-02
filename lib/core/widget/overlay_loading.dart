import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/core/values/image_assets.dart';

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
        insetAnimationCurve: Curves.easeInOut,
        insetAnimationDuration: const Duration(milliseconds: 500),
        elevation: 0,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.px, vertical: 24.px),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(8.px),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Image.asset(ImageAssets.logo, width: 50.px, height: 50.px),
              Lottie.asset(
                ImageAssets.lottieLoading,
                repeat: true,
                reverse: true,
                height: 80.px,
                width: double.infinity,
              ),
              SizedBox(height: 8.px),
              Text(
                message ?? 'please_wait_process'.tr,
                style: const TextStyle(
                  color: AppColors.secondary20,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
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
    // hide();
    await Get.dialog(
      barrierDismissible: canPop ?? false,
      OverlayLoading(
        message: title,
        canPop: canPop ?? false,
      ),
    );
  }
}
