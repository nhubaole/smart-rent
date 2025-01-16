// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:get/get.dart';

class SuccessArgument {
  final String? firstText;
  final String? secondText;
  final String? thirdText;
  final String? fourthText;
  final String? fifthText;
  final String? leftButtonText;
  final String? rightButtonText;
  final Function()? leftButtonOnTap;
  final Function()? rightButtonOnTap;

  SuccessArgument({
    this.firstText,
    this.secondText,
    this.thirdText,
    this.fourthText,
    this.fifthText,
    this.leftButtonText,
    this.rightButtonText,
    this.leftButtonOnTap,
    this.rightButtonOnTap,
  });
}

class SuccessController extends GetxController {
  SuccessArgument? successArgument;
  @override
  void onInit() {
    final args = Get.arguments;
    if (args != null && args is SuccessArgument) {
      successArgument = args;
    } else {
      Get.back();
    }
    super.onInit();
  }
}
