import 'package:get/get.dart';
import 'package:smart_rent/core/resources/auth_methods.dart';
import 'package:smart_rent/modules/home/views/home_screen.dart';

class LoginVerifyController extends GetxController {
  static LoginVerifyController get instance => Get.find();

  Future<String> verifyOTP(String otp) async {
    String res = 'Some error occured';
    try {
      var isVerified = await AuthMethods.instance.verifyOTP(otp);

      isVerified ? Get.offAll(() => const HomeScreen()) : Get.back();
      res = 'success';
    } catch (error) {
      //Get.snackbar('error', error.toString());
      res = error.toString();
    }
    print(res);
    return res;
  }
}
