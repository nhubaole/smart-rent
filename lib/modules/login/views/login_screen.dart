import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_rent/core/values/app_colors.dart';
import 'package:smart_rent/core/widget/text_form_field_input.dart';
import 'package:smart_rent/modules/login/controllers/login_controller.dart';
import 'package:smart_rent/modules/login/views/login_verify_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
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
                color: secondary40,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 8,
            ),
            Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormFieldInput(
                      maxLength: 10,
                      textEditingController: controller.phoneNo,
                      labelText: 'Số điện thoại',
                      hintText: 'Nhập số điện thoại',
                      textInputType: TextInputType.phone,
                      borderRadius: BorderRadius.circular(8),
                      borderWidth: 2,
                      borderColor: primary60,
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
                      height: 8,
                    ),
                    // GestureDetector(
                    //   onTap: () {
                    //     if (formKey.currentState!.validate()) {
                    //       // LoginController.instance
                    //       //     .phoneAuthentication('0908069947');
                    //       // Get.to(() => const LoginVerifyScreen());
                    //     }
                    //   },
                    //   child: Container(
                    //     alignment: Alignment.center,
                    //     width: double.infinity,
                    //     decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.circular(100),
                    //         color: primary60),
                    //     child: const Padding(
                    //       padding: EdgeInsets.all(16.0),
                    //       child: Text(
                    //         'Đăng nhập',
                    //         style: TextStyle(
                    //             color: Colors.white,
                    //             fontSize: 16,
                    //             fontWeight: FontWeight.w400),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          try {
                            if (formKey.currentState!.validate()) {
                              print(controller.phoneNo.text.trim());
                              LoginController.instance.phoneAuthentication(
                                  controller.phoneNo.text.trim());
                              Get.to(() => const LoginVerifyScreen());
                            }
                          } catch (e) {
                            print('Lỗi: $e');
                          }
                        },
                        child: const Text('Đăng nhập'),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Bạn chưa có tài khoản?',
                          style: TextStyle(
                            color: secondary40,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Đăng ký ngay',
                            style: TextStyle(color: primary60),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
