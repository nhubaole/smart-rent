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

  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final phoneNo = TextEditingController(text: '0123456789');
  final password = TextEditingController(text: 'test');
  final isLoading = Rx<bool>(false);
  final obscureText = Rx<bool>(true);
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
      if (!loginFormKey.currentState!.validate()) {
        return;
      }
      loginFormKey.currentState!.save();
      isLoading.value = true;
      OverlayLoading.show(title: 'Đang đăng nhập...', canPop: true);
      logger.d('tag', '${phoneNo.text.trim()} ${password.text.trim()}');
      final result = await AuthRepoImpl().login(
        phoneNumber: phoneNo.text.trim(),
        password: password.text.trim(),
      );
      OverlayLoading.hide();

      
      // final result = await AuthRepoImpl().login(
      //   phoneNumber: '0916290520',
      //   password: 'Test1234',
      // );
      if (!result.isSuccess()) {
        AlertSnackbar.show(
          title: 'Thông báo',
          message: result.message ?? '',
          isError: true,
        );
        isLoading.value = false;

        return;
      } else {
        appManager.setSession(
          phoneNumber: phoneNo.text.trim(),
          password: password.text.trim(),
          newAccessToken: result.data['accessToken'],
          refreshToken: result.data['refreshToken'],
        );
        
        // appManager.setSession(
        //   phoneNumber: '0916290520',
        //   password: 'Test1234',
        //   newAccessToken: result.data['accessToken'],
        //   refreshToken: result.data['refreshToken'],
        // );
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
    } catch (error) {
      isLoading.value = false;
      AlertSnackbar.show(
        title: 'Thông báo',
        message: error.toString(),
        isError: true,
      );
    }
    
  }
}
