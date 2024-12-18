import 'package:get/get.dart';
import 'package:smart_rent/modules/home/controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.find<HomeController>();
  }
}
