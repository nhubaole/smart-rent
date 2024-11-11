import 'package:get/get.dart';
import 'package:smart_rent/modules/sign_contract/sign_contract_controller.dart';

class SignContractBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignContractController());
  }
}
