import 'dart:convert';

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
  Account? currentAccount;
  late SharedPreferences prefs;

  @override
  void onInit() {
    pageController = PageController(initialPage: 0);
    getInfoAccount();
    // initStorage();
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

  Future<void> getInfoAccount() async {
    String res = 'Something wrong';
    try {
      currentAccount = await AuthMethods.instance.getUserDetails();
      if (currentAccount != null) {
        Get.snackbar('info', currentAccount!.address);
        initSharedPreferences();
      } else {
        res = 'error';
      }
    } catch (error) {
      res = error.toString();
    }
  }

  void initSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        KeyValue.KEY_ACCOUNT_PHONENUMBER, currentAccount!.phoneNumber);
    await prefs.setString(KeyValue.KEY_ACCOUNT_UID, currentAccount!.uid);
    await prefs.setString(
        KeyValue.KEY_ACCOUNT_PHOTOURL, currentAccount!.photoUrl);
    await prefs.setString(
        KeyValue.KEY_ACCOUNT_USERNAME, currentAccount!.username);
    await prefs.setString(
        KeyValue.KEY_ACCOUNT_ADDRESS, currentAccount!.address);
    await prefs.setBool(KeyValue.KEY_ACCOUNT_SEX, currentAccount!.sex);
    await prefs.setInt(KeyValue.KEY_ACCOUNT_AGE, currentAccount!.age);

    String formattedDate =
        DateFormat('dd-MM-yyyy').format(currentAccount!.dateOfBirth!);

    await prefs.setString(KeyValue.KEY_ACCOUNT_DATEOFBIRTH, formattedDate);

    await prefs.setString(KeyValue.KEY_ACCOUNT_DATEOFCREATE,
        currentAccount!.dateOfCreate.toString());
    await prefs.setString(KeyValue.KEY_ACCOUNT_EMAIL, currentAccount!.email);
    Get.snackbar('Notify', 'message');
  }
}
