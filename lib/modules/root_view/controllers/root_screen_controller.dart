import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:smart_rent/modules/home/views/home_screen.dart';
import 'package:smart_rent/modules/manage_room/views/manage_room_screen.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

class RootScreenController extends GetxController {
  late PageController pageController;
  final RxInt selectedPage = 0.obs;

  final screens = [
    const HomeScreen(),
    const ManageRoomScreen(),
    // const Scaffold(),
    const Scaffold(),
    const Scaffold(),
    // ConversationScreen(),
    // ManageAccountScreen(),
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

  void ZIMLogin() {
    ZIMAppConfig appConfig = ZIMAppConfig();
    appConfig.appID = 2063303228;
    appConfig.appSign =
        "31062f3e9c522cd6fe3a210405fe72306e0ee2e1f865e5289db26dfea5a608c3";

    ZIMKit().init(
      appID: 2063303228, // your appid
      appSign:
          "31062f3e9c522cd6fe3a210405fe72306e0ee2e1f865e5289db26dfea5a608c3", // your appSign
    );

    ZIM.create(appConfig);

    ZIMUserInfo userInfo = ZIMUserInfo();

    ZIM.getInstance()?.login(userInfo).then((value) {
      print("Login successful");
    }).catchError((onError) {
      switch (onError.runtimeType) {
        //This will be triggered when login failed.
        case PlatformException:
          print(onError.code); //Return the error code when login failed.
          print(onError.message!); // Return the error indo when login failed.
          break;
        default:
      }
    });
    ZIMKit()
        .connectUser(
            id: userInfo.userID,
            name: userInfo.userName,
            avatarUrl: 'currentAccount.photoUrl')
        .then((value) => null);
  }

  void animateToTab(int page) {
    selectedPage.value = page;
    pageController.animateToPage(page,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }
}
