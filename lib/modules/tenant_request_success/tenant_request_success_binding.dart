import 'package:get/get.dart';
import 'package:smart_rent/modules/tenant_request_success/tenant_request_success_controller.dart';

class TenantRequestSuccessBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TenantRequestSuccessController());
  }
}
