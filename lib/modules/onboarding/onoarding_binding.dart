import 'package:get/get.dart';
import 'package:smart_rent/modules/onboarding/onboarding_controller.dart';

class OnoardingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OnBoardingController());
  }
}
