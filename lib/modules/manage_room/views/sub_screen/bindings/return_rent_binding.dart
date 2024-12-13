import 'package:get/get.dart';
import 'package:smart_rent/modules/manage_room/controllers/sub_screen_controller/return_rent_controller.dart';

class ReturnRentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ReturnRentController());
  }
}
