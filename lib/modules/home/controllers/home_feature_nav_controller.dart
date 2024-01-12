import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeFeatureNavController extends GetxController {
  void jumpToScreen(Widget screen) {
    Get.to(() => screen);
  }
}
