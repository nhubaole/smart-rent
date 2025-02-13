import 'package:get/get.dart';
import 'package:smart_rent/modules/tenant_rent_return/tenant_rent_return_controller.dart';

class TenantRentReturnBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TenantRentReturnController());
  }
}
