import 'package:get/get.dart';
import 'package:smart_rent/modules/landlord_bill_collection/landlord_bill_collection_controller.dart';

class LandlordBillCollectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LandlordBillCollectionController());
  }
}
