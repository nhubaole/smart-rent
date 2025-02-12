import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_rent/core/enums/loading_type.dart';
import 'package:smart_rent/core/enums/type_faculty.dart';
import 'package:smart_rent/core/model/billing/billing_create_index_request_model.dart';
import 'package:smart_rent/core/model/billing/billing_list_index_by_landlord_model.dart';
import 'package:smart_rent/core/repositories/billing/billing_repo_impl.dart';
import 'package:smart_rent/core/widget/alert_snackbar.dart';
import 'package:smart_rent/core/widget/overlay_loading.dart';
import 'package:smart_rent/modules/manage_electricity_water_index/widgets/write_electricity_index_sheet.dart';

class ManageElectricityWaterIndexController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;

  final tabs = [
    'rented'.tr,
    // 'available_empty'.tr,
  ];

  final selectedTab = 0.obs;
  final typeSelected = TypeFaculty.electricity.obs;
  final periodSelected = DateTime.now().obs;
  final isLoadingType = LoadingType.INIT.obs;
  final billingIndexs = RxList<BillingListIndexByLandlordModel>([]);

  List<TypeFaculty> get types => [
        TypeFaculty.electricity,
        TypeFaculty.water,
      ];

  List<DateTime> get periods => generatePeriods();
  bool get isWater => typeSelected.value == TypeFaculty.water;


  @override
  void onInit() {
    tabController = TabController(length: tabs.length, vsync: this);
    tabController.addListener(() {
      if (tabController.indexIsChanging) {
        selectedTab.value = tabController.index;
      }
    });

    fetchData();
    super.onInit();
  }

  fetchData() async {
    isLoadingType.value = LoadingType.LOADING;
    final rq = await BillingRepoImpl().getBillListIndexByLandlord(
      month: periodSelected.value.month,
      year: periodSelected.value.year,
      isWater: isWater,
    );
    if (rq.isSuccess()) {
      billingIndexs.value = rq.data!;
      isLoadingType.value = LoadingType.LOADED;
    } else {
      isLoadingType.value = LoadingType.ERROR;
    }
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

  onCreateNewIndex(int indexInBilling, int indexInfoPosition) async {
    Get.bottomSheet(
      isScrollControlled: true,
      isDismissible: true,
      WriteElectricityIndexSheet(
        billingIndexs: billingIndexs[indexInfoPosition],
        indexInBill: indexInBilling,
        isWater: isWater,
        onSubmit: ({
          required bill,
          required image,
          required index,
          required indexInfoPosition,
        }) =>
            onSubmitNewIndex(
          bill: bill,
          indexInfoPosition: indexInfoPosition,
          indexInBill: indexInBilling,
          value: index,
          image: image,
        ),
        indexInfoPosition: indexInfoPosition,
      ),
    );
  }

  onSubmitNewIndex({
    required BillingListIndexByLandlordModel bill,
    required int indexInfoPosition,
    required int value,
    required String image,
    required int indexInBill,
  }) async {
    FocusManager.instance.primaryFocus?.unfocus();
    Get.back();
    // OverlayLoading.show();
    final indexValue = isWater
        ? BillingCreateIndexRequestModel(
            waterIndex: value,
            roomId: bill.indexInfo![indexInBill].roomId,
            month: periodSelected.value.month,
            year: periodSelected.value.year,
          )
        : BillingCreateIndexRequestModel(
            electricityIndex: value,
            roomId: bill.indexInfo![indexInBill].roomId,
            month: periodSelected.value.month,
            year: periodSelected.value.year,
          );
    final rq = await BillingRepoImpl().createIndex(request: indexValue);
    OverlayLoading.hide();
    if (rq.isSuccess()) {
      // await fetchData();
      final response = rq.data!;
      // billingIndexs.value = billingIndexs.map((e) {
      //   if (e.roomId == response.roomId) {
      //     e.indexInfo![indexInfoPosition].newIndex = index;
      //   }
      //   return e;
      // }).toList();
      billingIndexs[indexInfoPosition].indexInfo![indexInBill].newIndex =
          response.electricityIndex ?? response.waterIndex;
      if (billingIndexs[indexInfoPosition].indexInfo![indexInBill].newIndex !=
              null &&
          billingIndexs[indexInfoPosition].indexInfo![indexInBill].oldIndex !=
              null) {
        billingIndexs[indexInfoPosition].indexInfo![indexInBill].used =
            billingIndexs[indexInfoPosition].indexInfo![indexInBill].newIndex! -
                billingIndexs[indexInfoPosition]
                    .indexInfo![indexInBill]
                    .oldIndex!;
      }
      billingIndexs.refresh();

    } else {
      int index =
          billingIndexs.indexWhere((element) => element.roomId == bill.roomId);
      AlertSnackbar.show(
        title: 'Error',
        message: 'sent_request_failed'.tr,
        isError: true,
      );
      onCreateNewIndex(index, indexInfoPosition);
    }

  }
}
