import 'package:get/get.dart';
import 'package:smart_rent/core/extension/datetime_extension.dart';
import 'package:smart_rent/core/routes/app_routes.dart';
import 'package:smart_rent/modules/landlord_bill_collection/widgets/confirm_create_multi_bill_sheet.dart';

class LandlordBillCollectionController extends GetxController {
  final periodSelected = DateTime.now().toPediod.obs;

  List<DateTime> get periods => generatePeriods();

  final RxBool isMultipleSelectionMode = false.obs;
  final RxBool isSelectAllMode = false.obs;
  final selectedBills = [].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  onChangeSelectionMode(bool? value) {
    isMultipleSelectionMode.value = !isMultipleSelectionMode.value;
    if (isMultipleSelectionMode.value == false) {
      isSelectAllMode.value = false;
      selectedBills.clear();
    }
  }

  onChangeSelectAll(bool? value) {
    isSelectAllMode.value = !isSelectAllMode.value;
    if (isSelectAllMode.value) {
      selectedBills.clear();
      selectedBills.assignAll(
        [
          Object(),
          Object(),
          Object(),
        ],
      );
    } else {
      selectedBills.clear();
    }
  }

  onAddSelectedBill(Object object) {
    final index = selectedBills.indexWhere((item) => item == object);

    if (index == -1) {
      return _tryAddBill(Object());
    } else {
      _removeBillAtIndex(index);
    }
  }

  void _tryAddBill(Object object) {
    selectedBills.add(object);
  }

  void _removeBillAtIndex(int index) {
    selectedBills.removeAt(index);
  }

  onSelectItem(Object object) {
    if (!isMultipleSelectionMode.value) {
      Get.toNamed(AppRoutes.landlordPaymentDetail);
      return;
    }

    onAddSelectedBill(object);
  }

  onCreateMultiBills() {
    Get.bottomSheet(
      isScrollControlled: true,
      isDismissible: true,
      ConfirmCreateMultiBillSheet(
        billCounter: selectedBills.length,
        period: periodSelected.value,
        onConfirm: () {
          Get.back();
          Get.toNamed(AppRoutes.landlordBillInfo);
        },
      ),
    );
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
