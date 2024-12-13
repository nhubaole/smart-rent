import 'package:get/get.dart';
import 'package:smart_rent/modules/manage_electricity_water_index/manage_electricity_water_index_controller.dart';

class ManageElectricityWaterIndexBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ManageElectricityWaterIndexController>(() => ManageElectricityWaterIndexController());
  }
}