import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:smart_rent/firebase_contants.dart';
import 'package:smart_rent/modules/login/views/login_screen.dart';
import 'package:smart_rent/modules/root_view/views/root_screen.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<User?> firebaseUser;

  @override
  void onReady() {
    super.onReady();
    firebaseUser = Rx<User?>(auth.currentUser);
    firebaseUser.bindStream(auth.userChanges());

    ever(firebaseUser, _serInitialScreen);
  }

  _serInitialScreen(User? user) async {
    await Future.delayed(
      const Duration(seconds: 1),
    );
    if (user != null) {
      // user is logged in
      Get.offAll(
        () => const RootScreen(),
      );
    } else {
      // user is null as in user not available
      Get.offAll(
        () => const LoginScreen(),
      );
    }
  }
}
