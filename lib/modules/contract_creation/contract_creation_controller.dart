import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_rent/core/app/app_manager.dart';
import 'package:smart_rent/core/enums/electricity_payment_method.dart';
import 'package:smart_rent/core/model/contract/contract_template_create_model.dart';
import 'package:smart_rent/core/model/contract/template_model.dart';
import 'package:smart_rent/core/repositories/contract/contract_repo_impl.dart';
import 'package:smart_rent/core/values/utils.dart';
import 'package:smart_rent/core/widget/alert_snackbar.dart';
import 'package:smart_rent/modules/contract_creation/widgets/electricity_payment_method_sheet.dart';

class ContractCreationController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  late TemplateModel selectedTemplate;

  final tabs = Rx<List<Map<String, dynamic>>>(List.generate(
    3,
    (index) => {
      'counter': index + 1,
      'isCompleted': false,
    },
  ));

  RxInt selectedTab = 0.obs;

  final rentalAddressController = TextEditingController();
  final electricityFeeController = TextEditingController();
  final waterFeeController = TextEditingController();
  final internetFeeController = TextEditingController();
  final parkingFeeController = TextEditingController();
  final responsibilityAController = TextEditingController();
  final responsibilityBController = TextEditingController();
  final generalResponsibilityController = TextEditingController();

  RxString electricityMethod = '₫/kwh'.obs;
  RxString waterMethod = '₫/người'.obs;
  RxBool useSystemTemplateA = false.obs;
  RxBool useSystemTemplateB = false.obs;
  RxBool useSystemTemplateGeneral = false.obs;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: tabs.value.length, vsync: this);

    final args = Get.arguments;
    if (args != null && args is Map<String, dynamic>) {
      selectedTemplate = args['template'];
    } else {
      Get.back();
      return;
    }

    rentalAddressController.text = selectedTemplate.address.join(", ");
    electricityFeeController.text =
        selectedTemplate.electricityCost.toString() == 'null'
            ? ''
            : selectedTemplate.electricityCost.toString();
    waterFeeController.text = selectedTemplate.waterCost.toString() == 'null'
        ? ''
        : selectedTemplate.waterCost.toString();
    internetFeeController.text =
        selectedTemplate.internetCost.toString() == 'null'
            ? ''
            : selectedTemplate.internetCost.toString();
    parkingFeeController.text = selectedTemplate.parkingFee.toString() == 'null'
        ? ''
        : selectedTemplate.parkingFee.toString();
    responsibilityAController.text = selectedTemplate.responsibilityA ?? '';
    responsibilityBController.text = selectedTemplate.responsibilityB ?? '';
    generalResponsibilityController.text =
        selectedTemplate.generalResponsibility ?? '';
  }

  @override
  void onClose() {
    rentalAddressController.dispose();
    electricityFeeController.dispose();
    waterFeeController.dispose();
    internetFeeController.dispose();
    parkingFeeController.dispose();
    responsibilityAController.dispose();
    responsibilityBController.dispose();
    generalResponsibilityController.dispose();
    tabController.dispose();
    super.onClose();
  }

  Future<bool> changeTab(int index) async {
    FocusManager.instance.primaryFocus?.unfocus();
    if (index >= 0) {
      if (index < tabs.value.length) {
        if (index > 0) {
          tabs.value[index - 1]['isCompleted'] = true;
        }

        selectedTab.value = index;
        tabController.animateTo(index);
        return true;
      } else {}
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

  ContractTemplateCreateModel getUpdatedTemplate() {
    return ContractTemplateCreateModel(
      address: selectedTemplate.address,
      partyA: AppManager().currentUser?.id ?? 0,
      electricityMethod: electricityMethod.value,
      electricityCost: parseCurrency(electricityFeeController.text),
      waterMethod: waterMethod.value,
      waterCost: parseCurrency(waterFeeController.text),
      internetCost: parseCurrency(internetFeeController.text),
      parkingFee: parseCurrency(parkingFeeController.text),
      responsibilityA: responsibilityAController.text,
      responsibilityB: responsibilityBController.text,
      generalResponsibility: generalResponsibilityController.text,
    );
  }

  void onSelectMethodTap() async {
    await Get.bottomSheet(
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
  }

  void onSubmit() async {
    try {
      final response =
          await ContractRepoImpl().createContractTemplate(getUpdatedTemplate());

      if (response.isSuccess()) {
        print("Contract template created successfully");
        Get.back();
        AlertSnackbar.show(
          isError: false,
          title: 'Thành công',
          message: 'Tạo mẫu hợp đồng thành công',
        );
      } else {
        AlertSnackbar.show(
          isError: true,
          title: 'Thất bại',
          message: response.message ?? "",
        );
        print("Error: ${response.message}");
      }
    } catch (e) {
      AlertSnackbar.show(
        isError: true,
        title: 'Thất bại',
        message: e.toString() ?? "",
      );
      print("Error: ${e.toString()}");
    }
  }
}

double parseCurrency(String value) {
  return double.tryParse(value.replaceAll(',', '')) ?? 0.0;
}
