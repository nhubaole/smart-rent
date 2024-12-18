import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_rent/core/app/app_manager.dart';
import 'package:smart_rent/core/extension/datetime_extension.dart';
import 'package:smart_rent/core/model/contract/contract_by_id_model.dart';
import 'package:smart_rent/core/model/user/user_model.dart';
import 'package:smart_rent/core/routes/app_routes.dart';

class LandlordContractCreateController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  ContractByIdModel? contractByIdModel;

  final tabs = Rx<List<Map<String, dynamic>>>(List.generate(
    3,
    (index) => {
      'counter': index + 1,
      'isCompleted': false,
    },
  ));

  final formKeyPageOne = GlobalKey<FormState>();
  final formKeyPageTwo = GlobalKey<FormState>();

  final formDateController =
      TextEditingController(text: DateTime.now().ddMMyyyy);
  final toDateController = TextEditingController(text: DateTime.now().ddMMyyyy);

  final selectedTab = 0.obs;

  final AppManager appManager = AppManager();

  UserModel get user => appManager.currentUser!;

  @override
  void onInit() {
    tabController = TabController(length: tabs.value.length, vsync: this);
    super.onInit();
  }

  Future<bool> changeTab(int index) async {
    FocusManager.instance.primaryFocus?.unfocus();
    selectedTab.value = index;
    tabController.animateTo(index);
    return false;
  }

  Future<bool> onStepTapped(int index) async {
    return await changeTab(index);
  }

  onTapChoseFromDate(BuildContext context) async {
    FocusManager.instance.primaryFocus?.unfocus();
    final fromDataAt = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (fromDataAt != null) {
      formDateController.text = fromDataAt.ddMMyyyy;
    }
  }

  onTapChoseToDate(BuildContext context) async {
    FocusManager.instance.primaryFocus?.unfocus();
    final toDataAt = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (toDataAt != null) {
      toDateController.text = toDataAt.ddMMyyyy;
    }
  }

  onClickBottomNav() {
    if (selectedTab.value == tabs.value.length - 1) {
      // create contract
      Get.toNamed(AppRoutes.contractSign);
    }
    if (selectedTab.value < tabs.value.length - 1) selectedTab.value++;
    tabController.animateTo(selectedTab.value);
  }
}
