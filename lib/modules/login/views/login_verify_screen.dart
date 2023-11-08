import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:smart_rent/core/values/app_colors.dart';
import 'package:smart_rent/core/values/utils.dart';
import 'package:smart_rent/modules/login/controllers/login_controller.dart';
import 'package:smart_rent/modules/login/controllers/login_verify_controller.dart';

class LoginVerifyScreen extends StatefulWidget {
  final String phoneNumber;
  const LoginVerifyScreen({
    super.key,
    required this.phoneNumber,
  });

  @override
  State<LoginVerifyScreen> createState() => _LoginVerifyScreenState();
}

class _LoginVerifyScreenState extends State<LoginVerifyScreen> {
  final controller = Get.put(LoginVerifyController());
  var otp;
  bool endTimer = false;
  bool isWrongOTP = false;
  bool isCorrectOTP = false;
  Timer? countdownTimer;
  Duration myDuration = const Duration(minutes: 5);
  void startTimer() {
    countdownTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
  }

  void setCountDown() {
    const reduceSecondsBy = 1;
    setState(() {
      final seconds = myDuration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        countdownTimer!.cancel();
        setState(() {
          endTimer = true;
        });
      } else {
        myDuration = Duration(seconds: seconds);
      }
    });
  }

  void _submit() async {
    String res = await LoginVerifyController.instance.verifyOTP(otp);
    if (res != 'success') {
      setState(
        () {
          isWrongOTP = true;
        },
      );
    } else if (res == 'success') {
      setState(
        () {
          isCorrectOTP = true;
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = strDigits(myDuration.inMinutes.remainder(60));
    final seconds = strDigits(myDuration.inSeconds.remainder(60));
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
                    text: widget.phoneNumber,
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
            RichText(
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
                    text: '$minutes:$seconds',
                    style: const TextStyle(
                      color: Colors.red,
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
                  otp = code;
                  //LoginVerifyController.instance.verifyOTP(otp);
                },
                pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                showCursor: true,
                onCompleted: (pin) {
                  otp = pin;
                  //LoginVerifyController.instance.verifyOTP(otp);
                },
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            endTimer
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
                          LoginController.instance
                              .phoneAuthentication(widget.phoneNumber);
                          // Get.to(
                          //   () => LoginVerifyScreen(
                          //     phoneNumber: widget.phoneNumber,
                          //   ),
                          // );
                        },
                        child: const Text(
                          'Gửi lại OTP',
                          style: TextStyle(color: primary60),
                        ),
                      ),
                    ],
                  )
                : const SizedBox(),
            const SizedBox(
              height: 8,
            ),
            isWrongOTP
                ? const Text(
                    'Mã OTP không đúng',
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  )
                : const SizedBox(),
            const SizedBox(
              height: 8,
            ),
            isCorrectOTP
                ? const CircularProgressIndicator()
                : GestureDetector(
                    onTap: _submit,
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
          ],
        ),
      ),
    );
  }
}
