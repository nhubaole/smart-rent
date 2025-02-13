import 'package:get/get.dart';
import 'package:smart_rent/modules/manage_room/controllers/sub_screen_controller/rented_room_controller.dart';

class RentingRoomBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RentedRoomController());
  }
}
