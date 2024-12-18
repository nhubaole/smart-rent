import 'package:get/get.dart';
import 'package:smart_rent/modules/landlord_payment_deposit/landlord_payment_deposit_controller.dart';

class LandlordPaymentDepositBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LandlordPaymentDepositController());
  }
}
