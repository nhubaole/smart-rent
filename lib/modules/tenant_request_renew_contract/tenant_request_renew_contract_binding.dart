import 'package:get/get.dart';
import 'package:smart_rent/modules/tenant_request_renew_contract/tenant_request_renew_contract_controller.dart';

class TenantRequestRenewContractBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TenantRequestRenewContractController());
  }
}
