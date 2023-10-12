import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';
import 'package:smart_rent/core/model/account/Account.dart';
import 'package:smart_rent/core/resources/auth_methods.dart';
import 'package:smart_rent/core/values/KEY_VALUE.dart';

class RootScreenController extends GetxController {
  final box = GetStorage();
  late PageController pageController;
  final RxInt selectedPage = 0.obs;
  Account? currentAccount;

  @override
  void onInit() {
    pageController = PageController(initialPage: 0);
    // getName();
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

  Future<String> getName() async {
    String res = 'Something wrong';
    try {
      currentAccount = await AuthMethods.instance.getUserDetails();
      if (currentAccount != null) {
        box.write(
            KeyValue.KEY_PHONENUMBER, currentAccount?.phoneNumber.toString());
        box.write(KeyValue.KEY_ACCOUNT_UID, currentAccount?.uid.toString());
        box.write(
            KeyValue.KEY_ACCOUNT_PHOTOURL, currentAccount?.photoUrl.toString());
        box.write(
            KeyValue.KEY_ACCOUNT_USERNAME, currentAccount?.username.toString());
        box.write(
            KeyValue.KEY_ACCOUNT_ADDRESS, currentAccount?.address.toString());
        box.write(KeyValue.KEY_ACCOUNT_SEX, currentAccount?.phoneNumber);
        box.write(KeyValue.KEY_ACCOUNT_AGE, currentAccount?.age);
        box.write(
            KeyValue.KEY_ACCOUNT_DATEOFBIRTH, currentAccount?.dateOfBirth);
        box.write(
            KeyValue.KEY_ACCOUNT_DATEOFCREATE, currentAccount?.dateOfCreate);
        box.write(KeyValue.KEY_ACCOUNT_EMAIL, currentAccount?.email);
        box.write(
            KeyValue.KEY_ACCOUNT_DATEOFCREATE, currentAccount?.dateOfCreate);
        box.write(KeyValue.KEY_ACCOUNT_ISONLINE, currentAccount?.isOnline);
      } else {
        res = 'error';
      }
      box.writeIfNull(KeyValue.KEY_NOTIFY_NEWMESSAGE, true);
      box.writeIfNull(KeyValue.KEY_NOTIFY_NEWLIKE, true);
      box.writeIfNull(KeyValue.KEY_NOTIFY_NEWSCHEDULE, true);
    } catch (error) {
      res = error.toString();
    }
    return res;
  }

  void initStorage() async {
    if (box.read(KeyValue.KEY_NOTIFY_NEWROOM) == null) {
      await box.writeIfNull(KeyValue.KEY_NOTIFY_NEWROOM, true);
      await box.writeIfNull(KeyValue.KEY_NOTIFY_NEWMESSAGE, true);
      await box.writeIfNull(KeyValue.KEY_NOTIFY_NEWLIKE, true);
      await box.writeIfNull(KeyValue.KEY_NOTIFY_NEWSCHEDULE, true);
      print('null');
      print('New room ${box.read(KeyValue.KEY_NOTIFY_NEWROOM)}');
      print('New mess ${box.read(KeyValue.KEY_NOTIFY_NEWMESSAGE)}');
      print('New like ${box.read(KeyValue.KEY_NOTIFY_NEWLIKE)}');
      print('New scehdule ${box.read(KeyValue.KEY_NOTIFY_NEWSCHEDULE)}');
    }
  }
}
