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
import 'package:smart_rent/core/widget/alert_snackbar.dart';
import 'package:smart_rent/core/widget/overlay_loading.dart';

class LoginController extends GetxController {
  late Log logger;
  final AppManager appManager = AppManager();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final phoneNo = TextEditingController(text: '0123456789');
  final password = TextEditingController(text: 'test');
  final isLoading = Rx<bool>(false);
  final obscureText = Rx<bool>(false);
  final phoneNoFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  @override
  void onInit() {
    logger = getIt<Log>();
    super.onInit();
  }

  @override
  void onClose() {
    phoneNo.dispose();
    password.dispose();
    phoneNoFocusNode.dispose();
    passwordFocusNode.dispose();
    super.onClose();
  }

  Future<void> submit() async {
    try {
      isLoading.value = true;
      OverlayLoading.show(title: 'Đang đăng nhập...', canPop: true);
      logger.d('tag', '${phoneNo.text.trim()} ${password.text.trim()}');
      final result = await AuthRepoImpl().login(
        phoneNumber: phoneNo.text.trim(),
        password: password.text.trim(),
      );
      if (!result.isSuccess()) {
        OverlayLoading.hide();
        AlertSnackbar.show(
          title: 'Thông báo',
          message: result.message ?? '',
          isError: true,
        );
        isLoading.value = false;

        return;
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
          OverlayLoading.hide();
          AlertSnackbar.show(
            title: 'Thông báo',
            message: result.message ?? '',
            isError: true,
          );
          isLoading.value = false;

        }

        Get.offAllNamed(AppRoutes.root);
      }

      // TODO: Testing
      // await Future.delayed(const Duration(seconds: 2));
      // isLoading.value = false;
      // OverlayLoading.hide();
    } catch (error) {
      OverlayLoading.hide();
      isLoading.value = false;
      AlertSnackbar.show(
        title: 'Thông báo',
        message: error.toString(),
        isError: true,
      );
    }
    
  }
}
