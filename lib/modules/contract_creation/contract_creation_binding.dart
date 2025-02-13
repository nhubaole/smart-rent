import 'package:get/get.dart';
import 'package:smart_rent/modules/contract_creation/contract_creation_controller.dart';

class ContractCreationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ContractCreationController>(() => ContractCreationController());
  }
}
