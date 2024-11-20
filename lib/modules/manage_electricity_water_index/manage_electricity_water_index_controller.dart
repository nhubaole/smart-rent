import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_rent/core/enums/type_faculty.dart';
import 'package:smart_rent/core/extension/datetime_extension.dart';

class ManageElectricityWaterIndexController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;

  final tabs = [
    'rented'.tr,
    'available_empty'.tr,
  ];

  final selectedTab = 0.obs;
  final typeSelected = TypeFaculty.electricity.obs;
  final periodSelected = DateTime.now().toPediod.obs;

  List<TypeFaculty> get types => [
        TypeFaculty.electricity,
        TypeFaculty.water,
      ];

  List<DateTime> get periods => generatePeriods();

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

  List<DateTime> generatePeriods({
    int? currentYear,
    int yearsBefore = 2,
    int yearsAfter = 2,
  }) {
    currentYear ??= DateTime.now().year;
    List<DateTime> periods = [];

    for (int year = currentYear - yearsBefore;
        year <= currentYear + yearsAfter;
        year++) {
      for (int month = 1; month <= 12; month++) {
        periods.add(DateTime(year, month));
      }
    }

    return periods;
  }
}
