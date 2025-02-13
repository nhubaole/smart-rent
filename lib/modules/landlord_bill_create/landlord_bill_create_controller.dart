import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_rent/core/enums/loading_type.dart';
import 'package:smart_rent/core/model/billing/bill_by_id_model.dart';
import 'package:smart_rent/core/model/billing/bill_by_month_and_user_model.dart';
import 'package:smart_rent/core/model/billing/bill_create_model.dart';
import 'package:smart_rent/core/model/billing/billing_all_metric_model.dart';
import 'package:smart_rent/core/repositories/billing/billing_repo_impl.dart';
import 'package:smart_rent/core/routes/app_routes.dart';
import 'package:smart_rent/core/widget/overlay_loading.dart';

class LandlordBillCreateController extends GetxController {
  BillByIdModel? billByIdModel;
  final period = Rxn<DateTime>();
  final createBillFormKey = GlobalKey<FormState>();
  late BillByMonthAndUserItemModel billByMonthAndUserItemModel;
  BillingAllMetricModel? billingAllMetricModel;
  final additionFeeController = TextEditingController();
  final additionNoteController = TextEditingController();


  final isLoadingData = LoadingType.INIT.obs;
  int get calElectricCost =>
      (billByIdModel!.newElectricityIndex! -
          billByIdModel!.oldElectricityIndex!) *
      billByIdModel!.electricityCost!;

  int get calWaterCost =>
      (billByIdModel!.newWaterIndex! - billByIdModel!.oldWaterIndex!) *
      billByIdModel!.waterCost!;


  @override
  void onInit() {
    final args = Get.arguments;
    if (args != null) {
      if (args is Map<String, dynamic>) {
        billByMonthAndUserItemModel = args['selected_bill'];
        period.value = args['period'];
        if (billByMonthAndUserItemModel.roomId != null &&
            period.value != null) {
          fetchMetricsByRoomIDAndPeriod();
        } else {
          Get.back();
        }
        // fetchBillById();
      } else {
        Get.back();
      }
    } else {
      Get.back();
    }
    super.onInit();
  }

  fetchMetricsByRoomIDAndPeriod() async {
    isLoadingData.value = LoadingType.INIT;
    final rq = await BillingRepoImpl().getBillAllMetric(
      roomID: billByMonthAndUserItemModel.roomId!,
      month: period.value!.month,
      year: period.value!.year,
    );
    if (rq.isSuccess()) {
      billingAllMetricModel = rq.data;
      convertToBillByIdModel(billingAllMetricModel!);
      isLoadingData.value = LoadingType.LOADED;
    } else {
      isLoadingData.value = LoadingType.ERROR;
    }
  }

  fetchBillById() async {
    isLoadingData.value = LoadingType.INIT;
    final rq = await BillingRepoImpl()
        .getBillByID(billID: billByMonthAndUserItemModel.id!);
    if (rq.isSuccess()) {
      billByIdModel = rq.data;
      isLoadingData.value = LoadingType.LOADED;
    } else {
      isLoadingData.value = LoadingType.ERROR;
    }
  }

  convertToBillByIdModel(BillingAllMetricModel billingAllMetricModel) {
    billByIdModel = BillByIdModel(
      id: null,
      roomPrice: billingAllMetricModel.actualPrice,
      oldElectricityIndex: billingAllMetricModel.oldElectricityIndex,
      newElectricityIndex: billingAllMetricModel.newElectricityIndex,
      electricityCost: billingAllMetricModel.electricityCost,
      oldWaterIndex: billingAllMetricModel.oldWaterIndex,
      newWaterIndex: billingAllMetricModel.newWaterIndex,
      waterCost: billingAllMetricModel.waterCost,
      internetCost: billingAllMetricModel.internetCost,
      parkingFee: billingAllMetricModel.parkingFee,
      totalAmount: billingAllMetricModel.totalAmount,
      info: billingAllMetricModel.info,
    );
  }

  onCreateBill() async {
    createBillFormKey.currentState!.save();
    final BillCreateModel model = BillCreateModel(
      roomId: billByMonthAndUserItemModel.roomId!,
      month: period.value!.month,
      year: period.value!.year,
      additionFee: additionFeeController.text.trim().isNotEmpty
          ? int.parse(additionFeeController.text.trim())
          : 0,
      additionNote: additionNoteController.text.trim(),
    );

    OverlayLoading.show();
    final rq = await BillingRepoImpl().createBill(
      model: model,
    );
    OverlayLoading.hide();
    if (rq.isSuccess()) {
      billByMonthAndUserItemModel.id = rq.data;
      Get.offNamed(AppRoutes.landlordBillInfo, arguments: {
        'selected_bill': billByMonthAndUserItemModel,
        'period': period.value,
      });
    } else {
      Get.snackbar('Error', rq.message!);
    }
  }
}
