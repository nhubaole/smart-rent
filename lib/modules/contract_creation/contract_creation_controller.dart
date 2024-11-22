import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContractCreationController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;

  final tabs = Rx<List<Map<String, dynamic>>>(List.generate(
    4,
    (index) => {
      'counter': index + 1,
      'isCompleted': false,
    },
  ));

  RxInt selectedTab = 0.obs;

  @override
  void onInit() {
    tabController = TabController(length: tabs.value.length, vsync: this);

    super.onInit();
  }

  void changeTab(int index) {
    if (index >= 0 && index < tabs.value.length) {
      if (index > 0) {
        tabs.value[index - 1]['isCompleted'] = true;
      }
      selectedTab.value = index;
      tabController.animateTo(index);
      print(tabs.value);
    }
  }

  void onStepTapped(int index) {
    changeTab(index);
  }

  void onNextPage() {
    changeTab(selectedTab.value + 1);
  }
}
