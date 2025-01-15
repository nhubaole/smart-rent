import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/core/model/values/listProvinceVietNam.dart';
import 'package:smart_rent/core/routes/app_routes.dart';
import 'package:smart_rent/core/values/image_assets.dart';
import 'package:smart_rent/core/widget/outline_text_filed_widget.dart';
import 'package:smart_rent/core/widget/scaffold_widget.dart';
import 'package:smart_rent/core/widget/solid_button_widget.dart';
import 'package:smart_rent/modules/auth/signup/controllers/sign_up_controllers.dart';

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
                  SizedBox(height: 16.px),
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
                    fontSize: 16.sp,
                  ),
                ),
                TextSpan(
                  text: ' Điều khoản dịch vụ và chính sách bảo mật',
                  style: TextStyle(
                    color: AppColors.primary60,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 30.px),
          // controller.isVerifying.value
          //     ? const Center(
          //         child: CircularProgressIndicator(
          //           backgroundColor: AppColors.primary40,
          //           color: AppColors.primary95,
          //         ),
          //       )
          //     : CommonButton(
          //         title: 'Đăng ký ngay',
          //         onClick: () async {
          //           if (controller.signUpFormKey.currentState!.validate()) {
          //             controller.signUpFormKey.currentState!.save();
          //             String? result = await controller.onRegister();
          //             if (result != null) {
          //               Get.dialog(
          //                 barrierDismissible: false,
          //                 transitionCurve: Curves.decelerate,
          //                 transitionDuration: const Duration(milliseconds: 450),
          //                 DialogOTP(
          //                   phoneNumber: controller.phoneNumber.text.trim(),
          //                   callBack: (otp) {
          //                     print(otp);
          //                   },
          //                 ),
          //               );
          //             }
          //           }
          //         },
          //       ),
          SolidButtonWidget(
            text: 'Đăng ký ngay',
            onTap: () async {
              FocusManager.instance.primaryFocus?.unfocus();
              controller.onRegister();
            },
            child: controller.isVerifying.value
                ? SizedBox(
                    height: 20.px,
                    width: 20.px,
                    child: _buildLoadingWidget(),
                  )
                : null,
          ),
          SizedBox(height: 30.px),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Bạn đã có tài khoản?',
                style: TextStyle(
                  color: AppColors.secondary40,
                  fontSize: 16.sp,
                ),
              ),
              TextButton(
                onPressed: () {
                  Get.offNamed(AppRoutes.login);
                },
                child: Text(
                  'Đăng nhập ngay',
                  style: TextStyle(
                    color: AppColors.primary60,
                    fontSize: 16.sp,
                  ),
                ),
              ),
            ],
          ),
        ],
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

  Form _buildForm(BuildContext context) {
    return Form(
      key: controller.signUpFormKey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.px),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            OutlineTextFiledWidget(
              textEditingController: controller.fullName,
              onValidate: (value) {
                if (value == null || value.isEmpty || value.length < 6) {
                  return 'Vui lòng nhập họ và tên';
                }
                return null;
              },
              hintText: 'Họ và tên (*)',
              prefixIcon: const Icon(
                Icons.person_outline,
                color: AppColors.primary60,
              ),
              textInputType: TextInputType.text,
              textInputAction: TextInputAction.next,
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
            ),
            SizedBox(height: 16.px),
            OutlineTextFiledWidget(
              textEditingController: controller.phoneNumber,
              onValidate: (value) {
                if (value == null || value.isEmpty || value.length < 10) {
                  return 'Vui lòng nhập số điện thoại';
                }
                return null;
              },
              hintText: 'Số điện thoại (*)',
              prefixIcon: const Icon(
                Icons.phone_android,
                color: AppColors.primary60,
              ),
              textInputType: TextInputType.phone,
              textInputAction: TextInputAction.next,
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
            ),
            SizedBox(height: 16.px),
            OutlineTextFiledWidget(
              textEditingController: controller.password,
              onValidate: (value) {
                if (value == null || value.isEmpty || value.length < 10) {
                  return 'Vui lòng nhập mật khẩu';
                }
                return null;
              },
              hintText: 'Mật khẩu (*)',
              prefixIcon: const Icon(
                Icons.lock_outline,
                color: AppColors.primary60,
              ),
              maxlines: 1,
              suffixIcon: GestureDetector(
                onTap: () {
                  controller.obscureText.value = !controller.obscureText.value;
                },
                child: Icon(
                  controller.obscureText.value
                      ? Icons.visibility_off
                      : Icons.visibility,
                  color: AppColors.primary60,
                ),
              ),
              obscureText: controller.obscureText.value,
              textInputType: TextInputType.phone,
              textInputAction: TextInputAction.next,
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
            ),
            SizedBox(height: 16.px),
            DropdownButtonFormField(
              items: provinces
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Text(
                        e,
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: AppColors.secondary20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                controller.address.text = value.toString();
              },
              menuMaxHeight: MediaQuery.of(context).size.height * 0.4,
              value: controller.address.text,
              decoration: InputDecoration(
                hintText: 'Tỉnh/Thành phố (*)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.px),
                  borderSide: const BorderSide(
                    color: AppColors.secondary80,
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

  Widget _buildTitle() {
    return Column(
      children: [
        Image.asset(ImageAssets.logo, width: 70.px),
        SizedBox(height: 8.px),
        Text(
          'Tạo tài khoản mới',
          style: TextStyle(
            color: AppColors.primary10,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 4.px),
        Text(
          'Đăng ký ngay hôm nay để tìm được\n phòng trọ ưng ý',
          style: TextStyle(
            color: AppColors.secondary40,
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
