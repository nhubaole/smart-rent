import 'package:get/get.dart';
import 'package:smart_rent/modules/tenant_rent_request/tenant_rent_request_controller.dart';

class TenantRentRequestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TenantRentRequestController());
  }
}
