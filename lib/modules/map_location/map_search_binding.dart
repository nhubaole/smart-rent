import 'package:get/get.dart';
import 'package:smart_rent/modules/map_location/map_search_controller.dart';

class MapSearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MapSearchController());
  }
}
