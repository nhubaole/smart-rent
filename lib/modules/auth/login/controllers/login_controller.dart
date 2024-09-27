import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_rent/modules/auth/controller/auth_controller.dart';
import 'package:smart_rent/core/di/getit_config.dart';
import 'package:smart_rent/modules/root_view/views/root_screen.dart';

import '../../../../core/app/app_manager.dart';
import '../../../../core/repositories/auth/auth_repo_impl.dart';
import '../../../../core/repositories/log/log.dart';

class LoginController extends GetxController {
  late Log log;

  final AppManager appManager = AppManager();

  final formKey = GlobalKey<FormState>();
  final phoneNo = TextEditingController(text: '0123456789');
  final password = TextEditingController(text: 'test');
  var isLoading = Rx<bool>(false);

  @override
  void onInit() {
    log = getIt<Log>();
    super.onInit();
  }

  @override
  void onReady() {
    super.onClose();
  }

  Future<String?> submit() async {
    try {
      isLoading.value = true;
      log.d('tag', '${phoneNo.text.trim()} ${password.text.trim()}');
      final result = await AuthRepoImpl(log).login(
        phoneNumber: phoneNo.text.trim(),
        password: password.text.trim(),
      );
      final authController = getIt<AuthController>();
      if (result.errCode == null || result.errCode! >= 400) {
        authController.clearInfo();
        Get.snackbar('Thông báo', result.message ?? '');
        return 'Xảy ra lỗi';
      } else {
        appManager.setSession(
          newUserName: 'userName',
          newAccessToken: result.data['accessToken'],
          refreshToken: result.data['refreshToken'],
        );
        isLoading.value = false;

        Get.offAll(() => const RootScreen());
        return result.message;
      }
    } catch (error) {
      isLoading.value = false;
      Get.snackbar('Error', error.toString());
    }
    return null;
  }
}
