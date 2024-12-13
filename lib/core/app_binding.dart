import 'package:get/get.dart';
import 'package:smart_rent/modules/auth/controller/auth_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
  }
}
