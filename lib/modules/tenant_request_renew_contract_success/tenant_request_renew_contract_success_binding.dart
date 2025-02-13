import 'package:get/get.dart';
import 'package:smart_rent/modules/tenant_request_renew_contract_success/tenant_request_renew_contract_success_controller.dart';

class TenantRequestRenewContractSuccessBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TenantRequestRenewContractSuccessController());
  }
}
