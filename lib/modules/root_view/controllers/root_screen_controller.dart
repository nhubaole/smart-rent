import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_rent/core/model/account/Account.dart';
import 'package:smart_rent/core/resources/auth_methods.dart';
import 'package:smart_rent/core/values/key_value.dart';

class RootScreenController extends GetxController {
  late PageController pageController;
  final RxInt selectedPage = 0.obs;
  late Account currentAccount;
  late SharedPreferences prefs;

  @override
  void onInit() {
    pageController = PageController(initialPage: 0);
    getInfoAccount();
    setIsOnline(true);
    super.onInit();
  }

  void setIsOnline(bool isOnline) {
    FirebaseFirestore.instance
        .collection(KeyValue.KEY_COLLECTION_ACCOUNT)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({KeyValue.KEY_ACCOUNT_ISONLINE: isOnline});
  }

  @override
  void onClose() {
    pageController.dispose();
    setIsOnline(false);
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

  Future<void> getInfoAccount() async {
    currentAccount = await AuthMethods.getUserDetails();
    initSharedPreferences();
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

    String formattedDate =
        DateFormat('dd-MM-yyyy').format(currentAccount.dateOfBirth!);

    await prefs.setString(KeyValue.KEY_ACCOUNT_DATEOFBIRTH, formattedDate);

    await prefs.setString(KeyValue.KEY_ACCOUNT_DATEOFCREATE,
        currentAccount.dateOfCreate.toString());
    await prefs.setString(KeyValue.KEY_ACCOUNT_EMAIL, currentAccount.email);
    Get.snackbar('Notify', 'message');
  }
}
