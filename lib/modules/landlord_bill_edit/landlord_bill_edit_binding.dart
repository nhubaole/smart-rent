import 'package:get/get.dart';
import 'package:smart_rent/modules/landlord_bill_edit/landlord_bill_edit_controller.dart';

class LandlordBillEditBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LandlordBillEditController());
  }
}
