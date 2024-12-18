import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_rent/core/app/app_manager.dart';
import 'package:smart_rent/core/extension/datetime_extension.dart';
import 'package:smart_rent/core/extension/string_extension.dart';
import 'package:smart_rent/core/model/contract/contract_by_id_model.dart';
import 'package:smart_rent/core/model/user/user_model.dart';
import 'package:smart_rent/core/routes/app_routes.dart';
import 'package:smart_rent/core/widget/alert_snackbar.dart';
import 'package:smart_rent/modules/contract_sign/contract_sign_controller.dart';

class TenantRequestRenewContractController extends GetxController
    with GetSingleTickerProviderStateMixin {
  ContractByIdModel? contractByIdModel;

  late final TextEditingController formDateController;
  late final TextEditingController toDateController;
  late final TabController tabController;
  final tabs = [
    {
      'counter': 1,
    },
    {
      'counter': 2,
    }
  ];
  final activeTab = 0.obs;
  final AppManager appManager = AppManager();
  final formKeyDate = GlobalKey<FormState>();

  UserModel get user => appManager.currentUser!;

  @override
  void onInit() {
    tabController = TabController(length: tabs.length, vsync: this);
    formDateController = TextEditingController(text: DateTime.now().ddMMyyyy);
    toDateController = TextEditingController(text: DateTime.now().ddMMyyyy);
    final args = Get.arguments;
    if (args != null) {
      contractByIdModel = args['contract_by_id'];
    }
    super.onInit();
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
    if (activeTab.value == 0) {
      if (formKeyDate.currentState != null &&
          !formKeyDate.currentState!.validate()) {
        AlertSnackbar.show(
          title: 'Thiếu thông tin gia hạn',
          message: 'Vui lòng chọn ngày bắt đầu và kết thúc',
          isError: true,
        );
        return;
      }
      formKeyDate.currentState!.save();
      onNextPageView(1);
    } else {
      

      final arg = RenewContractArgument(
        contractByIdModel: contractByIdModel,
        startDate: formDateController.text.toDateTime,
        endDate: toDateController.text.toDateTime,
      );
      Get.toNamed(AppRoutes.contractSign, arguments: arg);
    }
  }

  onNextPageView(int index) {
    activeTab.value = index;
    tabController.animateTo(activeTab.value);
  }
}
