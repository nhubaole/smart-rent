import 'package:get/get.dart';
import 'package:smart_rent/modules/manage_room/controllers/sub_screen_controller/detail_request_controller.dart';

class DetailRequestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailRequestController>(() => DetailRequestController());
  }
}
