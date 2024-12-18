import 'package:get/get.dart';
import 'package:smart_rent/modules/tenant_rent_request_success/tenant_rent_request_success_controller.dart';

class TenantRentRequestSuccessBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TenantRentRequestSuccessController());
  }
}
