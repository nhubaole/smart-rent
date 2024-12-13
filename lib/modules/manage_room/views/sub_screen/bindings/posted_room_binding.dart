import 'package:get/get.dart';
import 'package:smart_rent/modules/manage_room/controllers/sub_screen_controller/posted_room_controller.dart';

class PostedRoomBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PostedRoomController());
  }
}
