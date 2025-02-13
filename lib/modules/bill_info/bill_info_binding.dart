import 'package:get/get.dart';
import 'package:smart_rent/modules/bill_info/bill_info_controller.dart';

class BillInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BillInfoController>(() => BillInfoController());
  }
}
