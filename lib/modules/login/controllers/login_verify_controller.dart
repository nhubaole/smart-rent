import 'dart:async';

import 'package:get/get.dart';
import 'package:smart_rent/core/resources/auth_methods.dart';
import 'package:smart_rent/modules/root_view/views/root_screen.dart';

class LoginVerifyController extends GetxController {
  var endTimer = Rx<bool>(false);
  var isWrongOTP = Rx<bool>(false);
  var isCorrectOTP = Rx<bool>(false);
  var otp = Rx<String>('');
  var isVerifying = Rx<bool>(false);
  Timer? countdownTimer;
  Duration myDuration = const Duration(minutes: 5);
  String strDigits(int n) => n.toString().padLeft(2, '0');
  var minutes = Rx<String>('');
  var seconds = Rx<String>('');
  @override
  onInit() {
    minutes.value = strDigits(myDuration.inMinutes.remainder(60));
    seconds.value = strDigits(myDuration.inSeconds.remainder(60));
    startTimer();
    super.onInit();
  }

  void startTimer() {
    countdownTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
  }

  void setCountDown() {
    const reduceSecondsBy = 1;
    final secondsRemaining = myDuration.inSeconds - reduceSecondsBy;
    if (secondsRemaining < 0) {
      countdownTimer!.cancel();
      endTimer.value = true;
    } else {
      myDuration = Duration(seconds: secondsRemaining);
      minutes.value = strDigits(myDuration.inMinutes.remainder(60));
      seconds.value = strDigits(myDuration.inSeconds.remainder(60));
    }
  }

  void submit() async {
    isVerifying.value = true;
    String res = await verifyOTP(otp.value);
    if (res != 'success') {
      isWrongOTP.value = true;
    } else if (res == 'success') {
      isCorrectOTP.value = true;
    }
    isVerifying.value = false;
  }

  Future<String> verifyOTP(String otp) async {
    String res = 'Some error occured';
    try {
      var isVerified = await AuthMethods.loginWithOtp(
        otp: otp,
      ).then(
        (value) {
          if (value == "Success") {
            Get.offAll(
              () => const RootScreen(),
            );
          } else {
            isWrongOTP.value = true;
            Get.snackbar('Thông Báo', 'Sai Mã OTP');
          }
        },
      );

      isVerified ? Get.to(() => const RootScreen()) : Get.back();
      res = 'success';
    } catch (error) {
      //Get.snackbar('error', error.toString());
      res = error.toString();
    }
    return res;
  }

  void phoneAuthentication(String phoneNo) async {
    AuthMethods.sentOtp(
      phone: phoneNo,
      errorStep: () => Get.snackbar('Thông báo', 'Lỗi gửi OTP'),
      nextStep: () => Get.snackbar('title', 'Sent Again'),
    );
  }
}
