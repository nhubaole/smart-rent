import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BillCollectionController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;

  final tabs = [
    'unpaid'.tr,
    'paid'.tr,
  ];

  final selectedTab = 0.obs;

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
