import 'package:get/get.dart';
import 'package:smart_rent/modules/manage_room/controllers/sub_screen_controller/request_rent_controller.dart';

class RequestRentV2Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RequestRentController());
  }
}
