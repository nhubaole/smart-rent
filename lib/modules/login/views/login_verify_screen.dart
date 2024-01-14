import 'dart:async';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:smart_rent/core/values/app_colors.dart';
import 'package:smart_rent/core/values/utils.dart';
import 'package:smart_rent/modules/login/controllers/login_verify_controller.dart';

class LoginVerifyScreen extends StatelessWidget {
  final String phoneNumber;
  const LoginVerifyScreen({
    super.key,
    required this.phoneNumber,
  });

  @override
  Widget build(BuildContext context) {
    final loginVerifyController = Get.put(LoginVerifyController());
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Xác thực OTP',
              style: TextStyle(
                color: primary10,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            const SizedBox(
              height: 4,
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: 'Vui lòng nhập mã OTP được gửi đến\nsố điện thoại ',
                    style: TextStyle(
                      color: secondary20,
                      fontSize: 14,
                    ),
                  ),
                  TextSpan(
                    text: phoneNumber,
                    style: const TextStyle(
                      color: secondary20,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Obx(
              () => RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: 'Có thể lấy lại OTP sau ',
                      style: TextStyle(
                        color: primary40,
                        fontSize: 14,
                      ),
                    ),
                    TextSpan(
                      text:
                          '${loginVerifyController.minutes}:${loginVerifyController.seconds}',
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 8,
              ),
              child: Pinput(
                length: 6,
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: focusedPinTheme,
                submittedPinTheme: submittedPinTheme,
                validator: (code) {
                  loginVerifyController.otp.value = code!;
                  //LoginVerifyController.instance.verifyOTP(otp);
                },
                pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                showCursor: true,
                onCompleted: (pin) {
                  loginVerifyController.otp.value = pin;
                  //LoginVerifyController.instance.verifyOTP(otp);
                },
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Obx(
              () => loginVerifyController.endTimer.value
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Bạn không nhận được OTP?',
                          style: TextStyle(
                            color: secondary40,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            loginVerifyController
                                .phoneAuthentication(phoneNumber);
                          },
                          child: const Text(
                            'Gửi lại OTP',
                            style: TextStyle(color: primary60),
                          ),
                        ),
                      ],
                    )
                  : const SizedBox(),
            ),
            const SizedBox(
              height: 8,
            ),
            Obx(
              () => !loginVerifyController.isVerifying.value &&
                      loginVerifyController.isWrongOTP.value
                  ? const Text(
                      'Mã OTP không đúng',
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    )
                  : const SizedBox(),
            ),
            const SizedBox(
              height: 8,
            ),
            Obx(
              () => loginVerifyController.isVerifying.value
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: primary95,
                        backgroundColor: primary40,
                      ),
                    )
                  : GestureDetector(
                      onTap: loginVerifyController.submit,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          alignment: Alignment.center,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: primary60),
                          child: const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text(
                              'Đăng nhập',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
