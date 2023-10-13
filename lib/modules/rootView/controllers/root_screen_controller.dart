import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:smart_rent/core/model/account/Account.dart';
import 'package:smart_rent/core/resources/auth_methods.dart';
import 'package:smart_rent/core/values/KEY_VALUE.dart';

class RootScreenController extends GetxController {
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
      } else {
        res = 'error';
      }
    } catch (error) {
      res = error.toString();
    }
    return res;
  }

  void initStorage() async {}
}
