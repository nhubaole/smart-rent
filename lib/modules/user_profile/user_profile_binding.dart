import 'package:get/get.dart';
import 'package:smart_rent/modules/user_profile/user_profile_controller.dart';

class UserProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserProfileController());
  }
}
