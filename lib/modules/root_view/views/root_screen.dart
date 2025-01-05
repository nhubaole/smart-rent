import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/core/widget/scaffold_widget.dart';
import '/modules/root_view/controllers/root_screen_controller.dart';

class RootScreen extends GetView<RootScreenController> {
  const RootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      body: PageView(
        onPageChanged: controller.animateToTab,
        controller: controller.pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: controller.screens,
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 5,
        ),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 2,
          ),
          child: GNav(
            tabActiveBorder: Border.all(color: AppColors.primary60, width: 1),
            haptic: true,
            //curve: Curves.easeOut,
            //duration: const Duration(milliseconds: 200),
            backgroundColor: Colors.white,
            gap: 15,
            color: Colors.black,
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 5,
            ),
            activeColor: AppColors.primary40,
            rippleColor: AppColors.primary95,
            hoverColor: AppColors.primary98,
            tabBackgroundColor: AppColors.primary98,
            onTabChange: (index) {
              controller.changeScreen(index);
            },
            tabs: const [
              GButton(icon: Icons.home_outlined, text: 'Trang Chủ'),
              GButton(icon: Icons.home_work_outlined, text: 'Phòng của bạn'),
              // GButton(icon: Icons.sms_outlined, text: 'Tin Nhắn'),
              GButton(icon: Icons.person_outline, text: 'Tài Khoản'),
            ],
          ),
        ),
      ),
    );
  }
}
