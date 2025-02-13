import 'package:get/get.dart';
import 'package:smart_rent/modules/manage_room/controllers/sub_screen_controller/liked_room_controller.dart';

class LikedRoomBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LikedRoomController());
  }
}
