//splash controller

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_rent/core/resources/auth_methods.dart';
import 'package:smart_rent/modules/login/views/login_screen.dart';
import 'package:smart_rent/modules/onboarding/views/onboarding_screen.dart';
import 'package:smart_rent/modules/root_view/views/root_screen.dart';

class SplashController extends GetxController {
  late SharedPreferences prefs;

  @override
  void onInit() async {
    prefs = await SharedPreferences.getInstance();

    checkStatusLogin();
    super.onInit();
  }

  Future<void> navigatorHomeScreen(BuildContext context) async {
    Future.delayed(
      const Duration(
        seconds: 3,
      ),
      () {
        Get.offAll(() => const LoginScreen(), transition: Transition.zoom);
      },
    );
  }

  void checkStatusLogin() async {
    final bool? repeat = prefs.getBool('first_install');

    await Future.delayed(
      const Duration(seconds: 3),
    );

    if (repeat == null) {
      await prefs.setBool('first_install', true);
      Get.offAll(const OnBoardingScreen());
    } else {
      AuthMethods.isLoggedIn().then(
        (value) {
          if (value) {
            Get.offAll(
              const RootScreen(),
            );
          } else {
            Get.offAll(
              const LoginScreen(),
            );
          }
        },
      );
    }
  }
}
