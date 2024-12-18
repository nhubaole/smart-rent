import 'package:get/get.dart';
import 'package:smart_rent/modules/landlord_return_success/landlord_return_success_controller.dart';

class LandlordReturnSuccessBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LandlordReturnSuccessController());
  }
}
