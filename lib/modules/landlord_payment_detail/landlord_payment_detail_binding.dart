import 'package:get/get.dart';
import 'package:smart_rent/modules/landlord_payment_detail/landlord_payment_detail_controller.dart';

class LandlordPaymentDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LandlordPaymentDetailController());
  }
}
