import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:im_stepper/stepper.dart';
import 'package:smart_rent/core/enums/room_type.dart';
import 'package:smart_rent/core/values/app_colors.dart';
import 'package:smart_rent/core/widget/button_outline.dart';
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
  int activeStep = 0; // Initial step set to 5.

  int upperBound = 5;

  List<Icon> icons = [
    Icon(Icons.info_outline, color: Colors.white),
    Icon(Icons.location_on_outlined, color: Colors.white),
    Icon(Icons.extension_outlined, color: Colors.white),
    Icon(Icons.verified_outlined, color: Colors.white),
  ]; // upperBound MUST BE total number of icons minus 1.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                IconStepper(
                  activeStepBorderWidth: 1,
                  stepRadius: 20.0,
                  activeStepBorderPadding: 8.0,
                  stepColor: secondary80,
                  activeStepColor: primary60,
                  activeStepBorderColor: primary60,
                  enableNextPreviousButtons: false,
                  lineLength: 60.0,
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
    return ButtonOutline(
        onPressed: () {
          if (activeStep < upperBound) {
            setState(() {
              activeStep++;
            });
          }
        },
        icon: Icon(Icons.arrow_forward),
        text: Text('data'),
        borderColor: primary60,
        borderRadius: BorderRadius.circular(100));
  }

  /// Returns the previous button.
  Widget previousButton() {
    return ElevatedButton(
      onPressed: () {
        // Decrement activeStep, when the previous button is tapped. However, check for lower bound i.e., must be greater than 0.
        if (activeStep > 0) {
          setState(() {
            activeStep--;
          });
        }
      },
      child: Text('Prev'),
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
        return LocationPage();

      case 2:
        return UtilitiesPage();

      case 3:
        return confirmPage();

      default:
        return InfoPage();
    }
  }

  Expanded locationPage() {
    return Expanded(
      child: FittedBox(
        child: Center(
          child: Text('$activeStep'),
        ),
      ),
    );
  }

  Expanded utilsPage() {
    return Expanded(
      child: FittedBox(
        child: Center(
          child: Text('$activeStep'),
        ),
      ),
    );
  }

  Expanded confirmPage() {
    return Expanded(
      child: FittedBox(
        child: Center(
          child: Text('$activeStep'),
        ),
      ),
    );
  }
}
