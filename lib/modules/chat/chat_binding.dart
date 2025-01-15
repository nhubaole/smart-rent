import 'package:get/get.dart';
import 'package:smart_rent/modules/chat/chat_controller.dart';

class ChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatController>(() => ChatController());
  }
}
