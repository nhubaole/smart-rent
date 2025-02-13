import 'package:get/get.dart';
import 'package:smart_rent/modules/contract/contract_controller.dart';

class ContractBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ContractController>(() => ContractController());
  }
}
