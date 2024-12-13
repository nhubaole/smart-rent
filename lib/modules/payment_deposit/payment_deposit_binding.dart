import 'package:get/get.dart';
import 'package:smart_rent/modules/payment_deposit/payment_deposit_controller.dart';

class PaymentDepositBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PaymentDepositController());
  }
}
