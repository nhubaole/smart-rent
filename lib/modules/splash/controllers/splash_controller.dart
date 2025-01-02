//splash controller

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:smart_rent/core/app/app_manager.dart';
import 'package:smart_rent/core/app/app_storage.dart';
import 'package:smart_rent/core/routes/app_routes.dart';

class SplashController extends GetxController {
  final AppManager appManager = AppManager();
  @override
  void onInit() async {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    super.onInit();
  }

  @override
  void onClose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.onClose();
  }

  @override
  void onReady() async {
    await checkStatusLogin();
    super.onReady();
  }

  Future<void> navigatorHomeScreen(BuildContext context) async {
    Future.delayed(
      const Duration(seconds: 1),
      () {
        Get.offAllNamed(AppRoutes.login);
      },
    );
  }

  Future<void> checkStatusLogin() async {
    final bool? repeat = AppStorage.getFistTimeInstall();
    await Future.delayed(
      const Duration(seconds: 3),
    );

    if (repeat == null) {
      await AppStorage.putFirstTimeInstall(value: true);
      Get.offAllNamed(AppRoutes.onBoarding);
    } else {
      if (appManager.accessToken != null && appManager.refreshToken != null) {
        Get.offAllNamed(AppRoutes.root);
      } else {
        Get.offAllNamed(AppRoutes.login);
      }
    }
  }
}
