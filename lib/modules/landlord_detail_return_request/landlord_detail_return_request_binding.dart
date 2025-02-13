import 'package:get/get.dart';
import 'package:smart_rent/modules/landlord_detail_return_request/landlord_detail_return_request_controller.dart';

class LandlordDetailReturnRequestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LandlordDetailReturnRequestController());
  }
}
