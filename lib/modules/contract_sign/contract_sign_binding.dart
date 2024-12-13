import 'package:get/get.dart';
import 'package:smart_rent/modules/contract_sign/contract_sign_controller.dart';

class ContractSignBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ContractSignController());
  }
}
