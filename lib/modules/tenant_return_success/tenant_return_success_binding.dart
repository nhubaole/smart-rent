import 'package:get/get.dart';
import 'package:smart_rent/modules/tenant_return_success/tenant_return_success_controller.dart';

class TenantReturnSuccessBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TenantReturnSuccessController());
  }
}
