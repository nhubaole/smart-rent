//splash controller

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_rent/modules/login/views/login_screen.dart';

class SplashController extends GetxController {
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
}
