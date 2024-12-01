import 'package:get/get.dart';
import 'package:smart_rent/modules/payment_detail/payment_detail_controller.dart';

class PaymentDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PaymentDetailController());
  }
}
