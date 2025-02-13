import 'package:get/get.dart';
import 'package:smart_rent/modules/manage_room/controllers/sub_screen_controller/wait_approve_room_controller.dart';

class WaitApproveBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WaitApproveRoomController());
  }
}
