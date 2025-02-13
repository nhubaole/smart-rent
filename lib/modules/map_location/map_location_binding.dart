import 'package:get/get.dart';
import 'package:smart_rent/modules/map_location/map_location_controller.dart';

class MapLocationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MapLocationController());
  }
}
