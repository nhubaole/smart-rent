import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../../core/config/app_colors.dart';
import '/core/values/app_colors.dart';
import '/modules/home/controllers/home_screen_controller.dart';
import '/modules/home/views/home_screen.dart';
import '/modules/manage_account/controllers/nav_controller/account_detail_controller.dart';
import '/modules/manage_room/controllers/manage_room_controller.dart';
import '/modules/root_view/controllers/root_screen_controller.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  final rootController = Get.put(RootScreenController(), permanent: true);
  final home = Get.lazyPut(
    () => HomeScreenController(),
    fenix: true,
  );
  final mgRoom = Get.lazyPut(
    () => ManageRoomController(),
    fenix: true,
  );
  final mgAccount = Get.lazyPut(
    () => ManageRoomController(),
    fenix: true,
  );
  final detailAccount = Get.lazyPut(
    () => AccountDetailController(),
    fenix: true,
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    //rootController.setIsOnline(false);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      const HomeScreen(),
      // ManageRoomScreen(),
      const Scaffold(),
      const Scaffold(),
      const Scaffold(),
      // ConversationScreen(),
      // ManageAccountScreen(),
    ];

    return Scaffold(
      body: PageView(
        onPageChanged: rootController.animateToTab,
        controller: rootController.pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: screens,
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
              rootController.changeScreen(index);
            },
            tabs: const [
              GButton(icon: Icons.home_outlined, text: 'Trang Chủ'),
              GButton(icon: Icons.home_work_outlined, text: 'Phòng của bạn'),
              GButton(icon: Icons.sms_outlined, text: 'Tin Nhắn'),
              GButton(icon: Icons.person_outline, text: 'Tài Khoản'),
            ],
          ),
        ),
      ),
    );
  }
}
