import 'package:get/get.dart';
import 'package:smart_rent/modules/landlord_bill_info/landlord_bill_info_controller.dart';

class LandlordBillInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LandlordBillInfoController());
  }
}
