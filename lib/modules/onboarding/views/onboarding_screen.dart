import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_rent/core/values/app_colors.dart';
import 'package:smart_rent/modules/login/views/login_screen.dart';
import 'package:smart_rent/modules/onboarding/controllers/onboarding_controller.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final OnBoardingController controller = Get.put(OnBoardingController());
  @override
  void initState() {
    super.initState();
    controller.pagesController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    super.dispose();
    controller.pagesController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          alignment: Alignment.center,
          children: [
            PageView.builder(
              onPageChanged: (index) {
                controller.currentPage.value = index;
                if (index == controller.listOnBoarding.length - 1) {
                  controller.isFinalPage.value = true;
                } else {
                  controller.isFinalPage.value = false;
                }
              },
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
                          onPressed: () {
                            controller.pagesController.jumpTo(controller
                                .pagesController.position.maxScrollExtent);
                          },
                          child: const Text(
                            'Bỏ qua',
                            style: TextStyle(
                              color: secondary40,
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
              child: Obx(
                () => GestureDetector(
                  onTap: () {
                    if (controller.isFinalPage.value) {
                      Get.off(
                        () => const LoginScreen(),
                        transition: Transition.rightToLeftWithFade,
                      );
                    }
                    controller.pagesController.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.ease,
                    );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: primary60,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: Text(
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

class OnBoardingContent extends StatelessWidget {
  final String image, title, subTitle, description;
  const OnBoardingContent({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    this.subTitle = '',
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 40,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Image.asset(
            image,
            height: 250,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: secondary20,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          subTitle != ''
              ? Text(
                  subTitle,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: primary40,
                    fontSize: 29,
                    fontWeight: FontWeight.bold,
                  ),
                )
              : const SizedBox(),
          const SizedBox(
            height: 8,
          ),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: primary10,
              fontSize: 14,
              fontWeight: FontWeight.w300,
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
