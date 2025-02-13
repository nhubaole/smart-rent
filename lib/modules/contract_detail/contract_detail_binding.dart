import 'package:get/get.dart';
import 'package:smart_rent/modules/contract_detail/contract_detail_controller.dart';

class ContractDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ContractDetailController());
  }
}
