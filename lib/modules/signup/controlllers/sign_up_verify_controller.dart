import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
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
            account = account.copyWith(
              uid: FirebaseAuth.instance.currentUser!.uid,
              dateOfCreate: DateTime.now(),
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

      // if (isVerified) {
      //   try {
      //     if (FirebaseAuth.instance.currentUser == null) {
      //       Get.snackbar('Lỗi', 'Không thể đăng ký');
      //       return 'not-success';
      //     }

      //     // Đăng ký => Thêm thông tin tài khoản vào FireStore

      //     Account currentAccount = Account(
      //       phoneNumber: account.phoneNumber,
      //       uid: FirebaseAuth.instance.currentUser!.uid,
      //       photoUrl: account.photoUrl,
      //       username: account.username,
      //       address: account.address,
      //       sex: account.sex,
      //       age: account.age,
      //       dateOfBirth: account.dateOfBirth,
      //       dateOfCreate: DateTime.now(),
      //     );

      //     String result =
      //         await FireStoreMethods().signUpUserFireStore(currentAccount);

      //     if (result != 'success') {
      //       Get.snackbar('Lỗi', result);
      //       return 'not-success';
      //     }

      //     // Đăng nhập => RootScreen
      //     Get.offAll(() => const RootScreen());
      //   } catch (e) {
      //     Get.snackbar('Lỗi', e.toString());
      //   }
      //   res = 'success';
      // } else {
      //   Get.back();
      // }
    } catch (error) {
      res = error.toString();
    }
    return res;
  }
}
