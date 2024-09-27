import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/config/app_colors.dart';
import '../../login/views/login_screen.dart';
import '../controllers/sign_up_controllers.dart';
import '/core/model/values/listProvinceVietNam.dart';
import '/core/values/app_colors.dart';
import '/core/widget/common_button.dart';
import '/core/widget/text_form_field_input.dart';
import 'dialog_otp.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final signUpController = Get.put(SignUpController());
    return SafeArea(
      child: Obx(
        () => Scaffold(
          resizeToAvoidBottomInset: false,
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildTitle(),
                  _buildForm(signUpController, context),
                  _buildButtons(signUpController),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButtons(SignUpController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          RichText(
            textAlign: TextAlign.center,
            text: const TextSpan(
              children: [
                TextSpan(
                  text: 'Bằng việc nhấn nút đăng ký, bạn đã đồng ý với các',
                  style: TextStyle(
                    color: AppColors.secondary20,
                    fontSize: 14,
                  ),
                ),
                TextSpan(
                  text: 'Điều khoản dịch vụ và chính sách bảo mật',
                  style: TextStyle(
                    color: AppColors.primary60,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          controller.isVerifying.value
              ? const Center(
                  child: CircularProgressIndicator(
                    backgroundColor: AppColors.primary40,
                    color: AppColors.primary95,
                  ),
                )
              : CommonButton(
                  title: 'Đăng ký ngay',
                  onClick: () async {
                    if (controller.signUpFormKey.currentState!.validate()) {
                      controller.signUpFormKey.currentState!.save();
                      String? result = await controller.onRegister();
                      if (result != null) {
                        Get.dialog(
                          barrierDismissible: false,
                          transitionCurve: Curves.decelerate,
                          transitionDuration: const Duration(milliseconds: 450),
                          DialogOTP(
                            phoneNumber: controller.phoneNumber.text.trim(),
                            callBack: (otp) {
                              print(otp);
                            },
                          ),
                        );
                      }
                    }
                  },
                ),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Bạn đã có tài khoản?',
                style: TextStyle(
                  color: AppColors.secondary40,
                ),
              ),
              TextButton(
                onPressed: () {
                  Get.to(
                    () => const LoginScreen(),
                  );
                },
                child: const Text(
                  'Đăng nhập ngay',
                  style: TextStyle(color: AppColors.primary60),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Form _buildForm(SignUpController signUpController, BuildContext context) {
    return Form(
      key: signUpController.signUpFormKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormFieldInput(
              textEditingController: signUpController.fullName,
              labelText: 'Họ và tên',
              hintText: 'Họ và tên (*)',
              textInputType: TextInputType.text,
              borderRadius: BorderRadius.circular(8),
              borderWidth: 2,
              borderColor: AppColors.primary60,
              icon: const Icon(Icons.person_outline),
              onSaved: (newValue) {},
              onValidate: (value) {
                if (value == null || value.isEmpty || value.length < 6) {
                  return 'Vui lòng nhập họ và tên';
                }
                return null;
              },
              autoCorrect: false,
              textCapitalization: TextCapitalization.none,
            ),
            const SizedBox(
              height: 15,
            ),
            TextFormFieldInput(
              maxLength: 10,
              textEditingController: signUpController.phoneNumber,
              labelText: 'Số điện thoại',
              hintText: 'Số điện thoại (*)',
              textInputType: TextInputType.phone,
              borderRadius: BorderRadius.circular(8),
              borderWidth: 2,
              borderColor: AppColors.primary60,
              icon: const Icon(Icons.phone_android),
              onSaved: (newValue) {},
              onValidate: (value) {
                if (value == null || value.isEmpty || value.length < 10) {
                  return 'Vui lòng nhập số điện thoại';
                }
                return null;
              },
              autoCorrect: false,
              textCapitalization: TextCapitalization.none,
            ),
            const SizedBox(
              height: 15,
            ),
            TextFormFieldInput(
              maxLength: 10,
              textEditingController: signUpController.password,
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
                if (value == null || value.isEmpty || value.length < 10) {
                  return 'Vui lòng nhập mật khẩu';
                }
                return null;
              },
              autoCorrect: false,
              textCapitalization: TextCapitalization.none,
            ),
            const SizedBox(
              height: 15,
            ),
            DropdownButtonFormField(
              items: provinces
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Text(e),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                signUpController.address.text = value.toString();
              },
              menuMaxHeight: MediaQuery.of(context).size.height * 0.4,
              decoration: InputDecoration(
                labelText: 'Tỉnh/Thành phố',
                hintText: 'Tỉnh/Thành phố (*)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: AppColors.primary60,
                    width: 2,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: AppColors.primary60,
                    width: 2,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: AppColors.primary60,
                    width: 2,
                  ),
                ),
                prefixIcon: const Icon(
                  Icons.place_outlined,
                  color: AppColors.primary60,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column _buildTitle() {
    return const Column(
      children: [
        Text(
          'Tạo tài khoản mới',
          style: TextStyle(
            color: primary10,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          'Đăng ký ngay hôm nay để tìm được\n phòng trọ ưng ý',
          style: TextStyle(
            color: AppColors.secondary40,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 16,
        ),
      ],
    );
  }
}
