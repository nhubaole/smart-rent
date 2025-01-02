import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/core/model/values/listProvinceVietNam.dart';
import 'package:smart_rent/core/routes/app_routes.dart';
import 'package:smart_rent/core/widget/common_button.dart';
import 'package:smart_rent/core/widget/scaffold_widget.dart';
import 'package:smart_rent/core/widget/text_form_field_input.dart';
import 'package:smart_rent/modules/auth/signup/controllers/sign_up_controllers.dart';
import 'package:smart_rent/modules/auth/signup/views/dialog_otp.dart';

class SignUpPage extends GetView<SignUpController> {
  const SignUpPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(
        () => ScaffoldWidget(
          resizeToAvoidBottomInset: false,
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildTitle(),
                  _buildForm(context),
                  _buildButtons(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButtons() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.px),
      child: Column(
        children: [
          SizedBox(height: 30.px),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Bằng việc nhấn nút đăng ký, bạn đã đồng ý với các',
                  style: TextStyle(
                    color: AppColors.secondary20,
                    fontSize: 14.sp,
                  ),
                ),
                TextSpan(
                  text: 'Điều khoản dịch vụ và chính sách bảo mật',
                  style: TextStyle(
                    color: AppColors.primary60,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 30.sp),
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
          SizedBox(height: 30.sp),
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
                  Get.offNamed(AppRoutes.login, preventDuplicates: true);
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

  Form _buildForm(BuildContext context) {
    return Form(
      key: controller.signUpFormKey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.px),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormFieldInput(
              textEditingController: controller.fullName,
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
            SizedBox(height: 16.px),
            TextFormFieldInput(
              maxLength: 10,
              textEditingController: controller.phoneNumber,
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
            SizedBox(height: 16.px),
            TextFormFieldInput(
              maxLength: 10,
              textEditingController: controller.password,
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
            SizedBox(height: 16.px),
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
                controller.address.text = value.toString();
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
    return Column(
      children: [
        Text(
          'Tạo tài khoản mới',
          style: TextStyle(
            color: AppColors.primary10,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8.px),
        Text(
          'Đăng ký ngay hôm nay để tìm được\n phòng trọ ưng ý',
          style: TextStyle(
            color: AppColors.secondary40,
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 16.px),
      ],
    );
  }
}
