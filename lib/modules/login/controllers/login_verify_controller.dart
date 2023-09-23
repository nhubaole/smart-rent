import 'package:get/get.dart';
import 'package:smart_rent/core/resources/auth_methods.dart';
import 'package:smart_rent/modules/home/views/home_screen.dart';

class LoginVerifyController extends GetxController {
  static LoginVerifyController get instance => Get.find();

  void verifyOTP(String otp) async {
    var isVerified = await AuthMethods.instance.verifyOTP(otp);
    isVerified ? Get.offAll(() => const HomeScreen()) : Get.back();
  }
}
