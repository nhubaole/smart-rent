import 'package:get/get.dart';
import 'package:smart_rent/modules/landlord_return_rating/landlord_return_rating_controller.dart';

class LandlordReturnRatingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LandlordReturnRatingController());
  }
}
