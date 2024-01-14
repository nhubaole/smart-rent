import 'package:get/get.dart';
import 'package:smart_rent/core/model/account/Account.dart';
import 'package:smart_rent/modules/signup/controlllers/sign_up_verify_controller.dart';

class DialogOtpController extends GetxController {
  var isWrongOTP = Rx<bool>(false);
  var isSubmit = Rx<bool>(false);
  var otp = Rx<String?>(null);
  void submit(String otp, Account user) async {
    isSubmit.value = true;
    String res = await SignUpVerifyController.instance.verifyOTP(otp, user);

    if (res != 'success') {
      isWrongOTP.value = true;
    } else {
      isWrongOTP.value = false;
    }
  }
}
