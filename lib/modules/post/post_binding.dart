import 'package:get/get.dart';
import 'package:smart_rent/modules/post/post_controller.dart';

class PostBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PostRoomController());
  }
}
