import 'package:get/get.dart';
import 'package:smart_rent/modules/success_page/success_controller.dart';

class SuccessBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SuccessController());
  }
}
