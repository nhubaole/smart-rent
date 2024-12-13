import 'package:get/get.dart';
import 'package:smart_rent/modules/payment_success/payment_success_controller.dart';

class PaymentSuccessBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PaymentSuccessController());
  }
}
