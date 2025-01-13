import 'package:get/get.dart';
import 'package:smart_rent/modules/home/controllers/home_controller.dart';
import 'package:smart_rent/modules/manage_room/controllers/manage_room_controller.dart';
import 'package:smart_rent/modules/root_view/controllers/root_screen_controller.dart';
import 'package:smart_rent/modules/user_profile/user_profile_controller.dart';

class RootBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RootScreenController());
    Get.put(HomeController());
    Get.put(ManageRoomController());
    Get.put(UserProfileController());
  }
}
