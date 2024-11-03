import 'package:get/get.dart';
import 'package:smart_rent/modules/manage_room/controllers/manage_room_controller.dart';

class ManageRoomBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ManageRoomController());
  }
}
