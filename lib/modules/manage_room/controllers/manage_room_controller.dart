import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ManageRoomController extends GetxController {
  void goToScreen(Widget accountDetailScreen) {
    Get.to(() => accountDetailScreen);
  }
}
