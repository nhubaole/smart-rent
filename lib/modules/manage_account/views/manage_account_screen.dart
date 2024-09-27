import 'package:flutter/material.dart';
import '../../../core/config/app_colors.dart';
import '/core/values/app_colors.dart';
import '/modules/manage_account/views/account_nav_button.dart';
import '/modules/manage_account/views/account_show_information.dart';

// ignore: must_be_immutable
class ManageAccountScreen extends StatelessWidget {
  ManageAccountScreen({super.key});
  late double deviceHeight;
  late double deviceWidth;
  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              width: deviceWidth,
              height: deviceHeight,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primary40,
                    AppColors.primary95,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment(0.0, -0.5),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  top: deviceHeight * 0.05,
                  left: deviceWidth * 0.05,
                ),
                child: const Text(
                  'Tài khoản',
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            Positioned(
              top: deviceHeight * 0.1,
              left: 0,
              right: 0,
              child: Container(
                height: deviceHeight,
                width: deviceWidth,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(deviceWidth * 0.1),
                    topRight: Radius.circular(deviceWidth * 0.1),
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: deviceHeight * 0.01,
                    ),
                    AccountShowInformation(),
                    SizedBox(
                      height: deviceHeight * 0.01,
                    ),
                    const AccountNavButton(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
