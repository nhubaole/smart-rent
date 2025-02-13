import 'package:get/get.dart';
import 'package:smart_rent/modules/contract_info/contract_info_controller.dart';

class ContractInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ContractInfoController());
  }
}
