import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:im_stepper/stepper.dart';
import 'package:smart_rent/core/values/app_colors.dart';

import '../../../core/config/app_colors.dart';
import '/core/widget/button_fill.dart';
import '/core/widget/button_outline.dart';
import '/modules/post/controllers/post_controller.dart';
import '/modules/post/views/confirm_page.dart';
import '/modules/post/views/info_page.dart';
import '/modules/post/views/location_page.dart';
import '/modules/post/views/utilities_page.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final PostController controller = Get.put(PostController());

  int activeStep = 0;

  int upperBound = 5; // upperBound MUST BE total number of icons minus 1.

  LocationPage locationPage = const LocationPage();
  UtilitiesPage utilitiesPage = const UtilitiesPage();
  ConfirmPage confirmPage = const ConfirmPage();
  InfoPage infoPage = const InfoPage();

  List<Icon> icons = [
    const Icon(Icons.info_outline, color: Colors.white),
    const Icon(Icons.location_on_outlined, color: Colors.white),
    const Icon(Icons.extension_outlined, color: Colors.white),
    const Icon(Icons.verified_outlined, color: Colors.white),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldKey,
      body: Scaffold(
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 10),
          child: nextButton(),
        ),
        appBar: AppBar(
          toolbarHeight: 64.0,
          title: const Text(
            'Đăng phòng',
            style: TextStyle(
                color: AppColors.primary40,
                fontSize: 24,
                fontWeight: FontWeight.bold),
          ),
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.dark,
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.primary40),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: primary80,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.primary95,
                  Colors.white,
                ],
              ),
            ),
          ),
          elevation: 0,
          automaticallyImplyLeading: true,
          titleSpacing: 0,
          iconTheme: const IconThemeData(color: AppColors.primary40),
        ),
        body: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconStepper(
                activeStepBorderWidth: 1,
                stepRadius: 16.0,
                activeStepBorderPadding: 8.0,
                stepColor: AppColors.secondary80,
                activeStepColor: AppColors.primary60,
                activeStepBorderColor: AppColors.primary60,
                enableNextPreviousButtons: false,
                lineLength: 50.0,
                lineColor: AppColors.primary60,
                icons: icons,

                // activeStep property set to activeStep variable defined above.
                activeStep: activeStep,

                // This ensures step-tapping updates the activeStep.
                onStepReached: (index) {
                  setState(() {
                    activeStep = index;
                  });
                },
              ),
              header(),
              contentPage(),
              //nextButton()
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     previousButton(),
              //     nextButton(),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }

  /// Returns the next button.
  Widget nextButton() {
    return SizedBox(
      height: 50,
      child: activeStep == 3
          ? ButtonFill(
              onPressed: () {
                if (controller.formInfoKey.currentState!.validate()) {
                  controller.formInfoKey.currentState!.save();
                  controller.postRoom();
                }
              },
              icon: const Icon(
                Icons.add_box_rounded,
                size: 20,
                color: Colors.white,
              ),
              text: const Text(
                'Đăng bài',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
              backgroundColor: AppColors.primary60,
              borderRadius: BorderRadius.circular(100))
          : ButtonOutline(
              borderWidth: 2,
              onPressed: () {
                bool allowNext = true;
                if (activeStep == 2) {
                  if (controller.pickedImages.value!.length >= 4 &&
                      controller.pickedImages.value!.length <= 20) {
                    controller.validImageTotal.value = true;
                  } else {
                    controller.validImageTotal.value = false;
                    allowNext = false;
                  }
                } else if (!controller.formInfoKey.currentState!.validate()) {
                  allowNext = false;
                }

                if (allowNext) {
                  if (activeStep == 0) {
                  } else if (activeStep == 1) {
                    controller.updateLocationRoom();
                  }
                }

                if (activeStep < upperBound - 2 && allowNext) {
                  setState(() {
                    activeStep++;
                  });
                }
              },
              icon: const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 20,
                color: AppColors.primary60,
              ),
              text: const Text(
                'Tiếp theo',
                style: TextStyle(
                    color: AppColors.primary60,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
              borderColor: AppColors.primary60,
              borderRadius: BorderRadius.circular(100)),
    );
  }

  /// Returns the header wrapping the header text.
  Widget header() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
      decoration: BoxDecoration(
          color: AppColors.primary95, borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          headerText(),
          style: const TextStyle(
            color: AppColors.primary60,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  // Returns the header text based on the activeStep.
  String headerText() {
    switch (activeStep) {
      case 1:
        return 'Địa chỉ';

      case 2:
        return 'Tiện ích';

      case 3:
        return 'Xác nhận';

      default:
        return 'Thông tin';
    }
  }

  Widget contentPage() {
    switch (activeStep) {
      case 1:
        return locationPage;

      case 2:
        return utilitiesPage;

      case 3:
        return confirmPage;

      default:
        return infoPage;
    }
  }
}
