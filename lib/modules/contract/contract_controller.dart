import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContractController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final tabs = [
    'awaiting'.tr,
    'active'.tr,
    'expired'.tr,
  ];

  RxInt selectedTab = 0.obs;

  late TabController tabController;

  @override
  void onInit() {
    tabController = TabController(length: tabs.length, vsync: this);

    tabController.addListener(() {
      if (tabController.indexIsChanging) {
        selectedTab.value = tabController.index;
      }
    });
    super.onInit();
  }
}
