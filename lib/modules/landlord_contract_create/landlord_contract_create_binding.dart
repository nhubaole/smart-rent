import 'package:get/get.dart';
import 'package:smart_rent/modules/landlord_contract_create/landlord_contract_create_controller.dart';

class LandlordContractCreateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LandlordContractCreateController());
  }
}
