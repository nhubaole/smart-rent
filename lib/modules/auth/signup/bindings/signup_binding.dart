import 'package:get/get.dart';
import '/modules/auth/signup/controllers/sign_up_controllers.dart';

class SignUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignUpController());
  }
}
