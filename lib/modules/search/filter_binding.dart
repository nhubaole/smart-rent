import 'package:get/get.dart';
import 'package:smart_rent/modules/search/controllers/filter_controller.dart';

class FilterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FilterController());
  }
}
