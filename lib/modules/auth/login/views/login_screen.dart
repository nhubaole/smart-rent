import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/core/helper/help_regex.dart';
import 'package:smart_rent/core/routes/app_routes.dart';
import 'package:smart_rent/core/values/image_assets.dart';
import 'package:smart_rent/core/widget/outline_text_filed_widget.dart';
import 'package:smart_rent/core/widget/scaffold_widget.dart';
import 'package:smart_rent/core/widget/solid_button_widget.dart';
import 'package:smart_rent/modules/auth/login/controllers/login_controller.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildHeader(),
            SizedBox(height: 32.px),
            _buildForm(),
            _buildNavigateSignUp(),
          ],
        ),
      ),
    );
  }

  Form _buildForm() {
    return Form(
      key: controller.formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.px),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            OutlineTextFiledWidget(
              focusNode: controller.phoneNoFocusNode,
              textEditingController: controller.phoneNo,
              textInputType: TextInputType.phone,
              textInputAction: TextInputAction.next,
              hintText: 'Nhập số điện thoại',
              prefixIcon: Icon(
                Icons.phone_android,
                color: AppColors.primary60,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: AppColors.primary60,
                  width: 1.px,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: AppColors.primary80,
                  width: 1.px,
                ),
              ),
              onValidate: (value) {
                if (value == null || value.isEmpty) {
                  return 'Vui lòng nhập số điện thoại';
                }

                if (!HelpRegex.isNumber(value)) {
                  return 'Vui lòng nhập đúng định dạng số';
                }
                return null;
              },
            ),
            SizedBox(height: 16.px),
            Obx(
              () => OutlineTextFiledWidget(
                focusNode: controller.passwordFocusNode,
                textEditingController: controller.password,
                textInputType: TextInputType.text,
                textInputAction: TextInputAction.done,
                obscureText: controller.obscureText.value,
                hintText: 'Mật khẩu (*)',
                prefixIcon: Icon(
                  Icons.lock_outline,
                  color: AppColors.primary60,
                ),
                maxlines: 1,
                suffixIcon: GestureDetector(
                  onTap: () {
                    controller.obscureText.value =
                        !controller.obscureText.value;
                  },
                  child: Icon(
                    controller.obscureText.value
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: AppColors.primary60,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: AppColors.primary60,
                    width: 1.px,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: AppColors.primary80,
                    width: 1.px,
                  ),
                ),
                onValidate: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập mật khẩu';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(height: 16.px),
            Obx(
              () => SolidButtonWidget(
                text: 'Đăng nhập ngay',
                onTap: () async {
                  FocusManager.instance.primaryFocus?.unfocus();
                  if (controller.isLoading.value) return;
                  if (controller.formKey.currentState!.validate()) {
                    controller.formKey.currentState!.save();
                    await controller.submit();
                  }
                },
                child: controller.isLoading.value
                    ? SizedBox(
                        height: 20.px,
                        width: 20.px,
                        child: _buildLoadingWidget(),
                      )
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Center _buildLoadingWidget() {
    return Center(
      child: CircularProgressIndicator(
        color: AppColors.primary95,
        backgroundColor: AppColors.primary80,
        strokeCap: StrokeCap.round,
        strokeWidth: 2.px,
        
      ),
    );
  }

  Column _buildNavigateSignUp() {
    return Column(
      children: [
        SizedBox(height: 8.px),
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
                Get.offNamed(AppRoutes.signUp, preventDuplicates: true);
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
        Image.asset(ImageAssets.logo, width: 100.px),
        SizedBox(height: 16.px),
        Text(
          'Chào mừng bạn đã trở lại',
          style: TextStyle(
            color: AppColors.primary10,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8.px),
        Text(
          'Đăng nhập để khám phá các phòng trọ\n tuyệt vời đang chờ đón bạn.',
          style: TextStyle(
            color: AppColors.secondary40,
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 8.px),
      ],
    );
  }
}
