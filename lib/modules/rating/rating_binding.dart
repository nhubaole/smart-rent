import 'package:get/get.dart';
import 'package:smart_rent/modules/rating/rating_controller.dart';

class RatingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RatingController());
  }
}
