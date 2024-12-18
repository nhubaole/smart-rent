import 'package:get/get.dart';
import 'package:smart_rent/modules/landlord_bill_create/landlord_bill_create_controller.dart';

class LandlordBillCreateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LandlordBillCreateController());
  }
}
