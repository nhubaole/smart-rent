//splash controller

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_rent/core/routes/app_routes.dart';
import '../../../core/app/app_manager.dart';
import '../../auth/login/views/login_screen.dart';
import '/modules/onboarding/views/onboarding_screen.dart';
import '/modules/root_view/views/root_screen.dart';

class SplashController extends GetxController {
  late SharedPreferences prefs;
  final AppManager appManager = AppManager();
  @override
  void onInit() async {
    prefs = await SharedPreferences.getInstance();
    super.onInit();
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
    final bool? repeat = prefs.getBool('first_install');
    await Future.delayed(
      const Duration(seconds: 3),
    );

    if (repeat == null) {
      await prefs.setBool('first_install', true);
      Get.offAll(const OnBoardingScreen());
    } else {
      if (appManager.accressToken != null && appManager.refreshToken != null) {
        Get.offAllNamed(AppRoutes.root);
      } else {
        Get.offAllNamed(AppRoutes.login);
      }
    }
  }
}
