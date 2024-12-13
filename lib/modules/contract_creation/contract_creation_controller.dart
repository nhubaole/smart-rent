import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_rent/core/enums/electricity_payment_method.dart';
import 'package:smart_rent/core/widget/alert_snackbar.dart';
import 'package:smart_rent/modules/contract_creation/widgets/electricity_payment_method_sheet.dart';

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

  Future<bool> changeTab(int index) async {
    FocusManager.instance.primaryFocus?.unfocus();
    if (index >= 0 && index < tabs.value.length) {
      if (index > 0) {
        if (index == 2) {
          final result = await Get.bottomSheet(
            isScrollControlled: true,
            isDismissible: false,
            ElectricityPaymentMethodSheet(
              electricityPaymentMethods: const [
                ElectricityPaymentMethod.noPaid,
                ElectricityPaymentMethod.byMeter,
                ElectricityPaymentMethod.byMonth,
                ElectricityPaymentMethod.byPerson,
              ],
              onChoseElectricityPaymentMethod: (value) {
                print('Payment method selected: ${value.name}');
              },
              onSaved: () {
                Get.back<bool>(result: true);
              },
            ),
          );
          if (result == null) return false;
        }
        tabs.value[index - 1]['isCompleted'] = true;
      }

      selectedTab.value = index;
      tabController.animateTo(index);
      return true;
    }
    return false;
  }

  Future<bool> onStepTapped(int index) async {
    if (index > selectedTab.value + 1) {
      if (tabs.value[selectedTab.value]['isCompleted'] == false) {
        AlertSnackbar.show(
          title: 'Error',
          message: 'You need to complete the previous step',
          isError: true,
        );
        return false;
      }
    }
    return await changeTab(index);
  }

  void onNextPage() {
    changeTab(selectedTab.value + 1);
  }
}
