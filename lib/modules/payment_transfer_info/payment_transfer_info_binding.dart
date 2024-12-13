import 'package:get/get.dart';
import 'package:smart_rent/modules/payment_transfer_info/payment_transfer_info_controller.dart';

class PaymentTransferInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PaymentTransferInfoController());
  }
}
