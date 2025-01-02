import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/modules/onboarding/onboarding_controller.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingPage extends GetView<OnBoardingController> {
  const OnBoardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          alignment: Alignment.center,
          children: [
            PageView.builder(
              onPageChanged: controller.onChangePage,
              itemCount: controller.listOnBoarding.length,
              controller: controller.pagesController,
              itemBuilder: (context, index) => controller.listOnBoarding[index],
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.05,
              right: MediaQuery.of(context).size.width * 0.04,
              child: Obx(
                () => Container(
                  child: !controller.isFinalPage.value
                      ? TextButton(
                          onPressed: controller.onIgnorePage,
                          child: const Text(
                            'Bỏ qua',
                            style: TextStyle(
                              color: AppColors.secondary40,
                              fontSize: 16,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        )
                      : const SizedBox(),
                ),
              ),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.06,
              right: MediaQuery.of(context).size.width * 0.04,
              child: GestureDetector(
                onTap: controller.onNextButton,
                  child: Container(
                    alignment: Alignment.center,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: AppColors.primary60,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                    child: Obx(
                      () => Text(
                        controller.isFinalPage.value ? 'Bắt đầu' : 'Tiếp tục',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.06,
              left: MediaQuery.of(context).size.width * 0.05,
              child: Obx(
                () => AnimatedSmoothIndicator(
                  activeIndex: controller.currentPage.value,
                  count: 3,
                  effect: const WormEffect(
                      activeDotColor: Color(0xFF272727), dotHeight: 5.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


