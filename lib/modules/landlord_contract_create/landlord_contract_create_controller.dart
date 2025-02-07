import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_rent/core/app/app_manager.dart';
import 'package:smart_rent/core/enums/payment_method.dart';
import 'package:smart_rent/core/extension/datetime_extension.dart';
import 'package:smart_rent/core/helper/help_regex.dart';
import 'package:smart_rent/core/model/contract/contract_by_id_model.dart';
import 'package:smart_rent/core/model/contract/contract_create_model.dart';
import 'package:smart_rent/core/model/rental_request/rental_request_by_id_model.dart';
import 'package:smart_rent/core/model/user/user_model.dart';
import 'package:smart_rent/core/routes/app_routes.dart';
import 'package:smart_rent/core/widget/alert_snackbar.dart';
import 'package:smart_rent/modules/landlord_contract_create/widgets/payment_method_sheet.dart';

class LandlordContractCreateController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  ContractByIdModel? contractByIdModel;
  UserModel? owner;
  late RentalRequestByIdModel rentalRequestById;
  final methodSelected = PaymentMethod.cash.obs;
  final createContractModel = Rxn<ContractCreateModel>();

  final tabs = Rx<List<Map<String, dynamic>>>(List.generate(
    3,
    (index) => {
      'counter': index + 1,
      'isCompleted': false,
    },
  ));

  final formKeyPageOne = GlobalKey<FormState>();
  final formKeyPageTwo = GlobalKey<FormState>();
  late final TextEditingController addressController;
  late final TextEditingController roomNumberController;
  late final TextEditingController retalPriceController;
  late final TextEditingController paymentMethodController;
  late final TextEditingController electricPriceController;
  late final TextEditingController waterPriceController;
  late final TextEditingController internetPriceController;
  late final TextEditingController parkingPriceController;
  late final TextEditingController depositPriceController;
  late final TextEditingController formDatePaidPerMonthController;
  late final TextEditingController responsiblePartyAController;
  late final TextEditingController responsiblePartyBController;
  late final TextEditingController responsiblejointCommonController;
  final fromDateController =
      TextEditingController(text: DateTime.now().ddMMyyyy);
  final toDateController = TextEditingController(text: DateTime.now().ddMMyyyy);
  final selectedTab = 0.obs;
  final AppManager appManager = AppManager();

  UserModel get user => appManager.currentUser!;

  @override
  void onInit() {
    final args = Get.arguments;
    if (args != null) {
      rentalRequestById = args['rental_request_by_id'];
      initController();
    } else {
      Get.back();
    }
    tabController = TabController(length: tabs.value.length, vsync: this);
    super.onInit();
  }

  onBack() {
    if (selectedTab.value == 0) {
      Get.back();
    } else {
      changeTab(selectedTab.value - 1);
    }
  }

  initController() {
    addressController = TextEditingController(
        text: rentalRequestById.room!.address ??
            rentalRequestById.room!.addresses?.join(', '));
    roomNumberController =
        TextEditingController(
        text: rentalRequestById.room!.roomNumber.toString());

    // Rental Price
    retalPriceController = TextEditingController(
       );
    retalPriceController
        .addListener(() => HelpRegex.formatCurrency(retalPriceController));
    retalPriceController.text =
        rentalRequestById.room!.totalPrice?.toInt().toString() ?? '0';

    paymentMethodController = TextEditingController(text: 'cash'.tr);

    // Electric Price
    electricPriceController = TextEditingController();
    electricPriceController
        .addListener(() => HelpRegex.formatCurrency(electricPriceController));
    electricPriceController.text = (rentalRequestById.room!.electricPrice ??
            rentalRequestById.room!.electricityCost)!
        .toInt()
        .toString();

    // Water Price
    waterPriceController = TextEditingController();
    waterPriceController
        .addListener(() => HelpRegex.formatCurrency(waterPriceController));
    waterPriceController.text =
        rentalRequestById.room!.waterCost?.toInt().toString() ?? '0';

    // Internet Price
    internetPriceController = TextEditingController();
    internetPriceController
        .addListener(() => HelpRegex.formatCurrency(internetPriceController));
    internetPriceController.text =
        rentalRequestById.room!.internetCost?.toInt().toString() ?? '0';

    // Parking Price
    parkingPriceController = TextEditingController();
    parkingPriceController
        .addListener(() => HelpRegex.formatCurrency(parkingPriceController));
    parkingPriceController.text =
        rentalRequestById.room!.parkingFee?.toInt().toString() ?? '0';

    // Deposit Price
    depositPriceController = TextEditingController();
    depositPriceController
        .addListener(() => HelpRegex.formatCurrency(depositPriceController));
    depositPriceController.text =
        rentalRequestById.room!.deposit?.toInt().toString() ?? '0';  

    formDatePaidPerMonthController =
        TextEditingController(text: DateTime.now().day.toString());
    responsiblePartyAController = TextEditingController();
    responsiblePartyBController = TextEditingController();
    responsiblejointCommonController = TextEditingController();

    
  }

  onTapChoseDatePaidPerMonth(BuildContext context) async {
    FocusManager.instance.primaryFocus?.unfocus();
    final fromDataAt = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (fromDataAt != null) {
      formDatePaidPerMonthController.text = fromDataAt.day.toString();
    }
  }

  Future<bool> changeTab(int index) async {
    FocusManager.instance.primaryFocus?.unfocus();
    selectedTab.value = index;
    tabController.animateTo(index);
    log('electedTab.value: ${selectedTab.value}');
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
      fromDateController.text = fromDataAt.ddMMyyyy;
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
    switch (selectedTab.value) {
      case 0:
        if (formKeyPageOne.currentState!.validate()) {
          formKeyPageOne.currentState!.save();
          final fromDate = DatetimeExt.getParsedDate(fromDateController.text);
          final toDate = DatetimeExt.getParsedDate(toDateController.text);
          if (fromDate == null || toDate == null) {
            AlertSnackbar.show(
              title: 'Thông báo',
              message: 'Vui lòng chọn ngày bắt đầu và kết thúc',
              isError: true,
            );
            return;
          }
          if (fromDate.difference(toDate).inSeconds >= 0) {
            AlertSnackbar.show(
              title: 'Thông báo',
              message: 'Ngày bắt đầu và kết thúc không được trùng nhau',
              isError: true,
            );
            return;
          }
          formKeyPageOne.currentState!.save();
          changeTab(1);
        }
        break;
      case 1:
        if (formKeyPageTwo.currentState!.validate()) {
          formKeyPageTwo.currentState!.save();
          changeTab(2);
        }
        break;
      case 2:
        // create contract
        createContractModel.value = ContractCreateModel(
          address: rentalRequestById.room?.addresses,
          partyA: rentalRequestById.room?.owner,
          partyB: rentalRequestById.sender?.id,
          requestId: rentalRequestById.id,
          roomId: rentalRequestById.room?.id,
          actualPrice:
              int.tryParse(retalPriceController.text.replaceAll('.', '')),
          paymentMethod: methodSelected.value,
          electricityCost:
              int.tryParse(electricPriceController.text.replaceAll('.', '')),
          waterCost:
              int.tryParse(waterPriceController.text.replaceAll('.', '')),
          internetCost:
              int.tryParse(internetPriceController.text.replaceAll('.', '')),
          parkingFee:
              int.tryParse(parkingPriceController.text.replaceAll('.', '')),
          deposit:
              int.tryParse(depositPriceController.text.replaceAll('.', '')),
          beginDate: DatetimeExt.convertDateFormat(fromDateController.text),
          endDate: DatetimeExt.convertDateFormat(toDateController.text),
          responsibilityA: responsiblePartyAController.text,
          responsibilityB: responsiblePartyBController.text,
          generalResponsibility: responsiblejointCommonController.text,
        );
        print(createContractModel.value);
        Get.toNamed(
          AppRoutes.contractSign,
          arguments: createContractModel.value,
        );
        break;
    }
    // if (selectedTab.value == tabs.value.length - 1) {
    //   // create contract
    //   Get.toNamed(AppRoutes.contractSign);
    // }
    // if (selectedTab.value < tabs.value.length - 1) selectedTab.value++;
    // tabController.animateTo(selectedTab.value);
  }

  showPaymentMethod() {
    FocusManager.instance.primaryFocus?.unfocus();
    Get.bottomSheet(
      Obx(
        () => PaymentMethodSheet(
          methodSelected: methodSelected.value,
          onTap: (method) {
            methodSelected.value = method;
            paymentMethodController.text = method.name;
          },
        ),
      ),
    );
  }
}
