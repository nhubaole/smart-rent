import 'package:get/get.dart';
import 'package:smart_rent/modules/tenant_sent_rent_request/tenant_sent_rent_request_controller.dart';

class TenantSentRentRequestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TenantSentRentRequestController());
  }
}
