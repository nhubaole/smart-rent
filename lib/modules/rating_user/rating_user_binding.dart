import 'package:get/get.dart';
import 'package:smart_rent/modules/rating_user/rating_user_controller.dart';

class RatingUserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RatingUserController());
  }
}
