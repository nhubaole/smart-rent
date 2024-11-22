import 'package:get/get.dart';
import 'package:smart_rent/modules/bill_collection/bill_collection_controller.dart';

class BillCollectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BillCollectionController>(() => BillCollectionController());
  }
}
