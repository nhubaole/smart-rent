import 'package:get/get.dart';
import 'package:smart_rent/core/enums/loading_type.dart';
import 'package:smart_rent/core/extension/datetime_extension.dart';
import 'package:smart_rent/core/model/billing/bill_by_month_and_user_model.dart';
import 'package:smart_rent/core/repositories/billing/billing_repo_impl.dart';
import 'package:smart_rent/core/routes/app_routes.dart';
import 'package:smart_rent/modules/landlord_bill_collection/widgets/confirm_create_multi_bill_sheet.dart';

class LandlordBillCollectionController extends GetxController {
  final periodSelected = DateTime.now().obs;

  List<DateTime> get periods => generatePeriods();

  final RxBool isMultipleSelectionMode = false.obs;
  final RxBool isSelectAllMode = false.obs;
  final selectedBills = <BillByMonthAndUserItemModel>[].obs;
  final billings = Rxn<BillByMonthAndUserModel>();
  final isLoadingData = LoadingType.INIT.obs;


  @override
  void onInit() {
    fetchBilling();
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  fetchBilling() async {
    isLoadingData.value = LoadingType.INIT;
    final rq = await BillingRepoImpl().getBillByMonthAndUser(
      month: periodSelected.value.month,
      year: periodSelected.value.year,
    );
    if (rq.isSuccess()) {
      billings.value = rq.data;
      isLoadingData.value = LoadingType.LOADED;
    } else {
      isLoadingData.value = LoadingType.ERROR;
    }
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
                 billings.value!.listBill!.toList()

      );
    } else {
      selectedBills.clear();
    }
  }

  onAddSelectedBill(BillByMonthAndUserItemModel item) {
    final index = selectedBills.indexWhere((item) => item == item);

    if (index == -1) {
      return _tryAddBill(item);
    } else {
      _removeBillAtIndex(index);
    }
  }

  void _tryAddBill(BillByMonthAndUserItemModel object) {
    selectedBills.add(object);
  }

  void _removeBillAtIndex(int index) {
    selectedBills.removeAt(index);
  }

  onSelectItem(BillByMonthAndUserItemModel object) {
    // if (!isMultipleSelectionMode.value) {
    //   Get.toNamed(AppRoutes.landlordPaymentDetail);
    //   return;
    // }

    if (!isMultipleSelectionMode.value) {
      Get.toNamed(AppRoutes.landlordBillCreate, arguments: {
        'selected_bill': object,
        'period': periodSelected.value,
      });
    } else {
      onAddSelectedBill(object);
    }

  }

  onCreateMultiBills() {
    Get.bottomSheet(
      isScrollControlled: true,
      isDismissible: true,
      ConfirmCreateMultiBillSheet(
        billCounter: selectedBills.length,
        period: periodSelected.value.toPediod,
        onConfirm: () {
          Get.back();
          // Get.toNamed(AppRoutes.landlordBillInfo);
          Get.toNamed(AppRoutes.landlordBillCreate, arguments: {
            'selected_bill': selectedBills,
            'period': periodSelected.value,
          });
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
