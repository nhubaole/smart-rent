import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_rent/core/config/app_constant.dart';
import 'package:smart_rent/core/routes/app_routes.dart';
import 'package:smart_rent/modules/onboarding/widgets/on_boarding_content_widget.dart';

class OnBoardingController extends GetxController {
  late PageController pagesController;
  RxInt currentPage = 0.obs;
  RxBool isFinalPage = false.obs;
  List<OnBoardingContentWidget> listOnBoarding = AppConstant.onBoardingContent;

  @override
  void onInit() {
    pagesController = PageController(initialPage: 0);
    super.onInit();
  }

  @override
  void onClose() {
    pagesController.dispose();
    super.onClose();
  }

  onChangePage(int index) {
    currentPage.value = index;
    if (index == listOnBoarding.length - 1) {
      isFinalPage.value = true;
    } else {
      isFinalPage.value = false;
    }
  }

  onIgnorePage() {
    pagesController.jumpTo(pagesController.position.maxScrollExtent);
  }

  onNextButton() {
    if (isFinalPage.value) {
      Get.offNamed(AppRoutes.login);
    }
    pagesController.nextPage(
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }
}
