import 'package:get/get.dart';
import 'package:smart_rent/modules/tenant_sent_return_request/tenant_sent_return_request_controller.dart';

class TenantSentReturnRequestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TenantSentReturnRequestController());
  }
}
