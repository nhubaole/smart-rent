import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:smart_rent/core/values/app_colors.dart';
import 'package:smart_rent/modules/chat/views/home_screen.dart';
import 'package:smart_rent/modules/home/views/home_screen.dart';
import 'package:smart_rent/modules/manage_account/views/manage_account_screen.dart';
import 'package:smart_rent/modules/manage_room/views/manage_room_screen.dart';
import 'package:smart_rent/modules/rootView/controllers/root_screen_controller.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  final rootController = Get.put(RootScreenController(), permanent: true);
  @override
  void initState() {
    super.initState();
    rootController.getName();
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      const HomeScreen(),
      const ManageRoomScreen(),
      const ChatScreen(),
      const ManageAccountScreen(),
    ];

    return Scaffold(
      body: PageView(
        onPageChanged: rootController.animateToTab,
        controller: rootController.pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: screens,
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   backgroundColor: primary95,
      //   foregroundColor: Colors.black,
      //   elevation: 24,
      //   shape: BeveledRectangleBorder(
      //     borderRadius: BorderRadius.circular(10.0),
      //     side: const BorderSide(
      //       color: Colors.blue,
      //       width: 1.0,
      //       style: BorderStyle.none,
      //     ),
      //   ),
      //   mini: true,
      //   child: const Icon(Icons.add),
      // ),
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
            tabActiveBorder: Border.all(color: primary60, width: 1),
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
            activeColor: primary40,
            rippleColor: primary95,
            hoverColor: Colors.yellow,
            tabBackgroundColor: primary98,
            onTabChange: (index) {
              rootController.changeScreen(index);
            },
            tabs: const [
              GButton(icon: Icons.home_outlined, text: 'Trang Chủ'),
              GButton(
                  icon: Icons.manage_search_outlined, text: 'Phòng của bạn'),
              GButton(icon: Icons.chat_bubble_outline, text: 'Tin Nhắn'),
              GButton(icon: Icons.manage_accounts_outlined, text: 'Tài Khoản'),
            ],
          ),
        ),
      ),
    );
  }
}
