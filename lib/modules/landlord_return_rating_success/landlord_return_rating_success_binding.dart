import 'package:get/get.dart';
import 'package:smart_rent/modules/landlord_return_rating_success/landlord_return_rating_success_controller.dart';

class LandlordReturnRatingSuccessBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LandlordReturnRatingSuccessController());
  }
}
