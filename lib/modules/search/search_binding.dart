import 'package:get/get.dart';
import 'package:smart_rent/modules/search/controllers/search_room_controller.dart';

class SearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SearchRoomController());
  }
}
