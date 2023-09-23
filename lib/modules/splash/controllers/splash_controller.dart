//splash controller

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_rent/modules/login/views/login_screen.dart';

Future<void> navigatorHomeScreen(BuildContext context) async {
  Future.delayed(
    const Duration(
      seconds: 3,
    ),
    () {
      Get.off(() => const LoginScreen());
    },
  );
}
