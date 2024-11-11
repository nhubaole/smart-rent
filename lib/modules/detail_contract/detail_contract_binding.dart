import 'package:get/get.dart';
import 'package:smart_rent/modules/detail_contract/detail_contract_controller.dart';

class DetailContractBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DetailContractController());
  }
}
