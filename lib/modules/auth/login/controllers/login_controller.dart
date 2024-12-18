import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_rent/core/app/app_hive.dart';
import 'package:smart_rent/core/app/app_manager.dart';
import 'package:smart_rent/core/config/app_constant.dart';
import 'package:smart_rent/core/repositories/auth/auth_repo_impl.dart';
import 'package:smart_rent/core/repositories/log/log.dart';
import 'package:smart_rent/core/repositories/user/user_repo_iml.dart';
import 'package:smart_rent/core/di/getit_config.dart';
import 'package:smart_rent/core/routes/app_routes.dart';
import 'package:smart_rent/core/widget/overlay_loading.dart';

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
      OverlayLoading.show(title: 'Đang đăng nhập...');
      logger.d('tag', '${phoneNo.text.trim()} ${password.text.trim()}');
      final result = await AuthRepoImpl(logger).login(
        phoneNumber: phoneNo.text.trim(),
        password: password.text.trim(),
      );
      if (result.errCode == null || result.errCode! >= 400) {
        Get.snackbar('Thông báo', result.message ?? '');
        OverlayLoading.hide();

        return 'Xảy ra lỗi';
      } else {
        appManager.setSession(
          newAccessToken: result.data['accessToken'],
          refreshToken: result.data['refreshToken'],
        );
        final userModel = await UserRepoIml().getCurrentUser(
          accessToken: result.data['accessToken'],
        );
        if (userModel.isSuccess()) {
          appManager.setSession(
            newUser: userModel.data!,
          );
          print(HiveManager.get(AppConstant.hiveSessionKey));
          print('accessToken: ${appManager.accessToken}');
          print('refreshToken: ${appManager.refreshToken}');
        } else {
          Get.snackbar('Thông báo', result.message ?? '');
          return 'Xảy ra lỗi';
        }

        isLoading.value = false;
        OverlayLoading.hide();

        Get.offAllNamed(AppRoutes.root);
        return result.message;
      }
    } catch (error) {
      OverlayLoading.hide();

      isLoading.value = false;
      Get.snackbar('Error', error.toString());
    }
    return null;
  }
}
