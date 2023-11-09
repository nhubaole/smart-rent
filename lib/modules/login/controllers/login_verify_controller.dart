import 'package:get/get.dart';
import 'package:smart_rent/core/resources/auth_methods.dart';
import 'package:smart_rent/modules/root_view/views/root_screen.dart';

class LoginVerifyController extends GetxController {
  static LoginVerifyController get instance => Get.find();

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
            Get.snackbar('Thông Báo', 'Sai Mã OTP');
          }
        },
      );

      isVerified ? Get.offAll(() => const RootScreen()) : Get.back();
      res = 'success';
    } catch (error) {
      //Get.snackbar('error', error.toString());
      res = error.toString();
    }
    return res;
  }
}
