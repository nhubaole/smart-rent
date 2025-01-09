import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_rent/core/app/app_manager.dart';
import 'package:smart_rent/core/enums/payment_method.dart';
import 'package:smart_rent/core/extension/datetime_extension.dart';
import 'package:smart_rent/core/model/contract/contract_by_id_model.dart';
import 'package:smart_rent/core/model/rental_request/rental_request_all_model.dart';
import 'package:smart_rent/core/model/user/user_model.dart';
import 'package:smart_rent/core/routes/app_routes.dart';
import 'package:smart_rent/modules/landlord_contract_create/widgets/payment_method_sheet.dart';

class LandlordContractCreateController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  ContractByIdModel? contractByIdModel;
  late RentalRequestAllModel rentalRequest;
  final methodSelected = PaymentMethod.no.obs;

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
  final formDateController =
      TextEditingController(text: DateTime.now().ddMMyyyy);
  final toDateController = TextEditingController(text: DateTime.now().ddMMyyyy);
  final selectedTab = 0.obs;
  final AppManager appManager = AppManager();

  UserModel get user => appManager.currentUser!;

  @override
  void onInit() {
    final args = Get.arguments;
    if (args != null) {
      rentalRequest = args['rental_request'];
      initController();
    } else {
      Get.back();
    }
    tabController = TabController(length: tabs.value.length, vsync: this);
    super.onInit();
  }

  initController() {
    addressController = TextEditingController(
        text: rentalRequest.room!.address ??
            rentalRequest.room!.addresses?.join(', '));
    roomNumberController =
        TextEditingController(text: rentalRequest.room!.roomNumber.toString());
    retalPriceController = TextEditingController();
    paymentMethodController = TextEditingController();
    electricPriceController = TextEditingController(
        text: rentalRequest.room!.electricPrice?.toString());
    waterPriceController =
        TextEditingController(text: rentalRequest.room!.waterCost?.toString());
    internetPriceController = TextEditingController(
        text: rentalRequest.room!.internetCost?.toString());
    parkingPriceController =
        TextEditingController(text: rentalRequest.room!.parkingFee?.toString());
    depositPriceController =
        TextEditingController(text: rentalRequest.room!.deposit?.toString());
    formDatePaidPerMonthController =
        TextEditingController(text: DateTime.now().ddMMyyyy);
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
      formDatePaidPerMonthController.text = fromDataAt.ddMMyyyy;
    }
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
