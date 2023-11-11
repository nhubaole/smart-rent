import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_rent/core/model/account/Account.dart';
import 'package:smart_rent/core/resources/auth_methods.dart';
import 'package:smart_rent/core/values/key_value.dart';
import 'package:zego_zim/zego_zim.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

class RootScreenController extends GetxController {
  late PageController pageController;
  final RxInt selectedPage = 0.obs;
  late Account currentAccount;
  late SharedPreferences prefs;

  @override
  void onInit() {
    pageController = PageController(initialPage: 0);
    getInfoAccount();
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
    userInfo.userID = currentAccount.phoneNumber; //Fill in a String type value.
    userInfo.userName = currentAccount.username; //Fill in a String type value.

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
        .connectUser(id: userInfo.userID, name: userInfo.userName)
        .then((value) => null);
  }

  void animateToTab(int page) {
    selectedPage.value = page;
    pageController.animateToPage(page,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

  Future<void> getInfoAccount() async {
    currentAccount = await AuthMethods.getUserDetails(
      FirebaseAuth.instance.currentUser!.uid,
    );
    initSharedPreferences();
    ZIMLogin();
  }

  Future<void> initSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        KeyValue.KEY_ACCOUNT_PHONENUMBER, currentAccount.phoneNumber);
    await prefs.setString(KeyValue.KEY_ACCOUNT_UID, currentAccount.uid);
    await prefs.setString(
        KeyValue.KEY_ACCOUNT_PHOTOURL, currentAccount.photoUrl);
    await prefs.setString(
        KeyValue.KEY_ACCOUNT_USERNAME, currentAccount.username);
    await prefs.setString(KeyValue.KEY_ACCOUNT_ADDRESS, currentAccount.address);
    await prefs.setBool(KeyValue.KEY_ACCOUNT_SEX, currentAccount.sex);
    await prefs.setInt(KeyValue.KEY_ACCOUNT_AGE, currentAccount.age);

    // String formattedDate =
    //     DateFormat('dd-MM-yyyy').format(currentAccount.dateOfBirth!);

    await prefs.setString(
        KeyValue.KEY_ACCOUNT_DATEOFBIRTH, currentAccount.dateOfBirth!);

    await prefs.setString(KeyValue.KEY_ACCOUNT_DATEOFCREATE,
        currentAccount.dateOfCreate.toString());
    await prefs.setString(KeyValue.KEY_ACCOUNT_EMAIL, currentAccount.email);
    if (prefs.getStringList(KeyValue.KEY_ROOM_LIST_RECENTLY) == null) {
      await prefs.setStringList(KeyValue.KEY_ROOM_LIST_RECENTLY, <String>[]);
    }
    Get.snackbar('Notify', 'message');
  }
}
