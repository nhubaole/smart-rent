import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:im_stepper/stepper.dart';
import 'package:smart_rent/core/enums/room_type.dart';
import 'package:smart_rent/core/values/app_colors.dart';
import 'package:smart_rent/core/widget/button_fill.dart';
import 'package:smart_rent/core/widget/button_outline.dart';
import 'package:smart_rent/modules/post/controllers/post_controller.dart';
import 'package:smart_rent/modules/post/views/confirm_page.dart';
import 'package:smart_rent/modules/post/views/info_page.dart';
import 'package:smart_rent/modules/post/views/location_page.dart';
import 'package:smart_rent/modules/post/views/utilities_page.dart';

import '../../../core/enums/gender.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final PostController controller = Get.put(PostController());

  int activeStep = 0;

  int upperBound = 5; // upperBound MUST BE total number of icons minus 1.

  LocationPage locationPage = LocationPage();
  UtilitiesPage utilitiesPage = UtilitiesPage();
  ConfirmPage confirmPage = ConfirmPage();
  InfoPage infoPage = InfoPage();

  List<Icon> icons = [
    Icon(Icons.info_outline, color: Colors.white),
    Icon(Icons.location_on_outlined, color: Colors.white),
    Icon(Icons.extension_outlined, color: Colors.white),
    Icon(Icons.verified_outlined, color: Colors.white),
  ];

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(useMaterial3: true),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        key: controller.scaffoldKey,
        body: Scaffold(
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 10),
            child: nextButton(),
          ),
          appBar: AppBar(
            toolbarHeight: 64.0,
            title: Text(
              'Đăng phòng',
              style: TextStyle(
                  color: primary40, fontSize: 24, fontWeight: FontWeight.bold),
            ),
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarBrightness: Brightness.light,
              statusBarIconBrightness: Brightness.dark,
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: primary40),
              onPressed: () => Navigator.of(context).pop(),
            ),
            backgroundColor: primary80,
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    primary95,
                    Colors.white,
                  ],
                ),
              ),
            ),
            elevation: 0,
            automaticallyImplyLeading: true,
            titleSpacing: 0,
            iconTheme: const IconThemeData(color: primary40),
          ),
          body: Container(
            color: Colors.white,
            child: Column(
              children: [
                IconStepper(
                  activeStepBorderWidth: 1,
                  stepRadius: 16.0,
                  activeStepBorderPadding: 8.0,
                  stepColor: secondary80,
                  activeStepColor: primary60,
                  activeStepBorderColor: primary60,
                  enableNextPreviousButtons: false,
                  lineLength: 50.0,
                  lineColor: primary60,
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
      ),
    );
  }

  /// Returns the next button.
  Widget nextButton() {
    return Container(
      height: 50,
      child: activeStep == 3
          ? ButtonFill(
              onPressed: () {
                if (controller.formInfoKey.currentState!.validate()) {
                  // post
                  print("POST");
                }
              },
              icon: Icon(
                Icons.add_box_rounded,
                size: 20,
                color: Colors.white,
              ),
              text: Text(
                'Đăng bài',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
              backgroundColor: primary60,
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
                    controller.updateInfoRoom();
                  } else if (activeStep == 1) {
                    controller.updateLocationRoom();
                  } else if (activeStep == 2) {
                    // TODO: retrieve and update images
                  }
                }

                if (activeStep < upperBound - 2 && allowNext) {
                  print("CITIES: ${controller.cities.length}");
                  print("upperbound: ${upperBound}");
                  print("Active step: ${activeStep}");
                  print("allowNext: ${allowNext}");
                  setState(() {
                    activeStep++;
                  });
                }
              },
              icon: Icon(
                Icons.arrow_forward_ios_rounded,
                size: 20,
                color: primary60,
              ),
              text: Text(
                'Tiếp theo',
                style: TextStyle(
                    color: primary60,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
              borderColor: primary60,
              borderRadius: BorderRadius.circular(100)),
    );
  }

  /// Returns the header wrapping the header text.
  Widget header() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.fromLTRB(20, 5, 20, 5),
      decoration: BoxDecoration(
          color: primary95, borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          headerText(),
          style: TextStyle(
            color: primary60,
            fontWeight: FontWeight.w600,
            fontSize: 18,
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
