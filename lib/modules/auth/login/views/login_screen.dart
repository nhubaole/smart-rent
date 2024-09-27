import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/config/app_colors.dart';
import '../../signup/views/sign_up_screen.dart';
import '../controllers/login_controller.dart';
import '/core/values/app_colors.dart';
import '/core/widget/text_form_field_input.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final loginController = Get.put(LoginController());
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildHeader(),
            _buildForm(loginController),
            _buildNavigateSignUp(),
          ],
        ),
      ),
    );
  }

  Form _buildForm(LoginController loginController) {
    return Form(
      key: loginController.formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormFieldInput(
              maxLength: 10,
              textEditingController: loginController.phoneNo,
              labelText: 'Số điện thoại',
              hintText: 'Nhập số điện thoại',
              textInputType: TextInputType.phone,
              borderRadius: BorderRadius.circular(8),
              borderWidth: 2,
              borderColor: AppColors.primary60,
              icon: const Icon(Icons.phone_android),
              onSaved: (newValue) {},
              onValidate: (value) {
                if (value!.isEmpty || value.length < 10) {
                  return 'Vui lòng nhập số điện thoại';
                }
                return null;
              },
              autoCorrect: false,
              textCapitalization: TextCapitalization.none,
            ),
            const SizedBox(
              height: 16,
            ),
            TextFormFieldInput(
              maxLength: 10,
              textEditingController: loginController.password,
              labelText: 'Mật khẩu',
              hintText: 'Mật khẩu (*)',
              textInputType: TextInputType.text,
              isPassword: true,
              borderRadius: BorderRadius.circular(8),
              borderWidth: 2,
              borderColor: AppColors.primary60,
              icon: const Icon(Icons.lock_outline),
              onSaved: (newValue) {},
              onValidate: (value) {
                if (value == null || value.isEmpty) {
                  return 'Vui lòng nhập mật khẩu';
                }
                return null;
              },
              autoCorrect: false,
              textCapitalization: TextCapitalization.none,
            ),
            const SizedBox(
              height: 16,
            ),
            Obx(
              () => loginController.isLoading.value
                  ? _buildLoadingWidget()
                  : _buildButtonLogin(loginController),
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector _buildButtonLogin(LoginController loginController) {
    return GestureDetector(
      onTap: () async {
        if (loginController.formKey.currentState!.validate()) {
          loginController.formKey.currentState!.save();
          await loginController.submit();
        }
      },
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: AppColors.primary60),
        child: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Đăng nhập ngay',
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400),
          ),
        ),
      ),
    );
  }

  Center _buildLoadingWidget() {
    return const Center(
      child: CircularProgressIndicator(
        color: AppColors.primary95,
        backgroundColor: AppColors.primary40,
      ),
    );
  }

  Column _buildNavigateSignUp() {
    return Column(
      children: [
        const SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Bạn chưa có tài khoản?',
              style: TextStyle(
                color: AppColors.secondary40,
              ),
            ),
            TextButton(
              onPressed: () {
                Get.to(
                  () => const SignUpScreen(),
                );
              },
              child: const Text(
                'Đăng ký ngay',
                style: TextStyle(color: AppColors.primary60),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Column _buildHeader() {
    return Column(
      children: [
        Image.asset('assets/images/ic_logo_login.png'),
        const SizedBox(
          height: 8,
        ),
        const Text(
          'Chào mừng bạn đã trở lại',
          style: TextStyle(
            color: primary10,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        const Text(
          'Đăng nhập để khám phá các phòng trọ\n tuyệt vời đang chờ đón bạn.',
          style: TextStyle(
            color: AppColors.secondary40,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }
}
