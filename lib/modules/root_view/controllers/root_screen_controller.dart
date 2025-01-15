import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_rent/modules/chat/views/conversation_screen.dart';
import 'package:smart_rent/modules/home/views/home_screen.dart';
import 'package:smart_rent/modules/manage_room/views/manage_room_screen.dart';
import 'package:smart_rent/modules/user_profile/user_profile_page.dart';

class RootScreenController extends GetxController {
  late PageController pageController;
  final RxInt selectedPage = 0.obs;

  final screens = [
    const HomePage(),
    const ManageRoomScreen(),
    // const Scaffold(),
    // const Scaffold(),
    // const Scaffold(),
    ConversationScreen(),
    UserProfilePage(),
  ];

  @override
  void onInit() {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    pageController = PageController(initialPage: 0);

    super.onInit();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  void changeScreen(int index) {
    selectedPage.value = index;
    pageController.jumpToPage(index);
  }

  void animateToTab(int page) {
    selectedPage.value = page;
    pageController.animateToPage(page,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }
}
