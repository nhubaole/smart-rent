import 'package:get/get.dart';
import 'package:smart_rent/modules/recently/recently_page_controller.dart';

class RecentlyPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RecentlyRoomController());
  }
}
