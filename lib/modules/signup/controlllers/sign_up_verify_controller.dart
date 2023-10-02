import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:smart_rent/core/model/account/Account.dart';
import 'package:smart_rent/core/resources/auth_methods.dart';
import 'package:smart_rent/core/resources/firestore_methods.dart';
import 'package:smart_rent/modules/home/views/home_screen.dart';

class SignUpVerifyController extends GetxController {
  static SignUpVerifyController get instance => Get.find();

  Future<bool> verifyOTP(String otp, Account account) async {
    var isVerified = await AuthMethods.instance.verifyOTP(otp);

    if (isVerified) {
      try {
        if (FirebaseAuth.instance.currentUser == null) {
          Get.snackbar('Lỗi', 'Không thể đăng ký');
          return false;
        }

        // neu la dang thi them data vao firestore

        Account currentAccount = Account(
          phoneNumber: account.phoneNumber,
          uid: FirebaseAuth.instance.currentUser!.uid,
          photoUrl: account.photoUrl,
          username: account.username,
          address: account.address,
          sex: account.sex,
          age: account.age,
          dateOfBirth: account.dateOfBirth,
          dateOfCreate: DateTime.now(),
        );

        String result =
            await FireStoreMethods().signUpUserFireStore(currentAccount);

        if (result != 'success') {
          Get.snackbar('Lỗi', result);
          return false;
        }

        // neu la dang nhap thi khong lam gi
        Get.offAll(() => const HomeScreen());
      } catch (e) {
        Get.snackbar('Lỗi', e.toString());
      }
      return true;
    } else {
      Get.back();
      return false;
    }
  }
}