import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_rent/core/app/app_hive.dart';
import 'package:smart_rent/core/config/app_constant.dart';
import 'package:smart_rent/core/repositories/user/user_repo_iml.dart';
import 'package:smart_rent/core/di/getit_config.dart';
import 'package:smart_rent/core/routes/app_routes.dart';
import 'package:smart_rent/modules/root_view/views/root_screen.dart';

import '../../../../core/app/app_manager.dart';
import '../../../../core/repositories/auth/auth_repo_impl.dart';
import '../../../../core/repositories/log/log.dart';

class LoginController extends GetxController {
  late Log logger;

  final AppManager appManager = AppManager();

  late final GlobalKey<FormState> formKey;
  final phoneNo = TextEditingController(text: '0123456789');
  final password = TextEditingController(text: 'test');
  var isLoading = Rx<bool>(false);

  @override
  void onInit() {
    logger = getIt<Log>();
    formKey = GlobalKey<FormState>();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    phoneNo.dispose();
    password.dispose();
    super.onClose();
  }

  Future<String?> submit() async {
    try {
      isLoading.value = true;
      logger.d('tag', '${phoneNo.text.trim()} ${password.text.trim()}');
      final result = await AuthRepoImpl(logger).login(
        phoneNumber: phoneNo.text.trim(),
        password: password.text.trim(),
      );
      if (result.errCode == null || result.errCode! >= 400) {
        Get.snackbar('Thông báo', result.message ?? '');
        return 'Xảy ra lỗi';
      } else {
        final userModel = await UserRepoIml(logger).getCurrentUser(
          accessToken: result.data['accessToken'],
        );
        if (userModel.data != null) {
          appManager.setSession(
            newUser: userModel.data!,
            newAccessToken: result.data['accessToken'],
            refreshToken: result.data['refreshToken'],
          );
          print(HiveManager().get(AppConstant.hiveSessionKey));
        }

        isLoading.value = false;

        Get.offAllNamed(AppRoutes.root);
        return result.message;
      }
    } catch (error) {
      isLoading.value = false;
      Get.snackbar('Error', error.toString());
    }
    return null;
  }
}
