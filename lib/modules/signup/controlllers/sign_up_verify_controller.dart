import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:smart_rent/core/model/account/Account.dart';
import 'package:smart_rent/core/resources/auth_methods.dart';
import 'package:smart_rent/core/resources/firestore_methods.dart';
import 'package:smart_rent/modules/root_view/views/root_screen.dart';

class SignUpVerifyController extends GetxController {
  static SignUpVerifyController get instance => Get.find();

  Future<String> verifyOTP(String otp, Account account) async {
    String res = 'Some error occured';
    try {
      var isVerified = await AuthMethods.loginWithOtp(
        otp: otp,
      ).then(
        (value) {
          if (value == "Success") {
            DateTime dateOfCreate = DateTime.now();
            String formattedDate =
                DateFormat('dd-MM-yyyy').format(dateOfCreate);

            account = account.copyWith(
              uid: FirebaseAuth.instance.currentUser!.uid,
              dateOfCreate: DateFormat.yMd().format(DateTime.now()),
            );

            FireStoreMethods().signUpUserFireStore(account);

            Get.offAll(
              () => const RootScreen(),
            );
            res = 'success';
          } else {
            Get.snackbar('Thông Báo', 'Sai Mã OTP');
          }
        },
      );
    } catch (error) {
      res = error.toString();
    }
    return res;
  }
}
