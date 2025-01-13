import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_rent/core/app/app_manager.dart';
import 'package:smart_rent/core/model/user/user_model.dart';
import 'package:smart_rent/core/routes/app_routes.dart';

class ManageRoomController extends GetxController {
  UserModel get user => AppManager().currentUser!;
  void goToScreen(Widget accountDetailScreen) {
    Get.to(() => accountDetailScreen);
  }

  onNavContract() {
    if (user.role == 0) {
      Get.toNamed(AppRoutes.contract);
    } else {
      // Get.toNamed(AppRoutes.contr)
    }
  }
}
