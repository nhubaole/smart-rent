import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_rent/core/enums/loading_type.dart';
import 'package:smart_rent/core/model/billing/bill_by_status_model.dart';
import 'package:smart_rent/core/repositories/billing/billing_repo_impl.dart';
import 'package:smart_rent/core/routes/app_routes.dart';

class BillCollectionController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;

  final tabs = [
    'unpaid'.tr,
    'paid'.tr,
  ];

  final selectedTab = 0.obs;
  final isLoadingData = LoadingType.INIT.obs;
  final billingUnpaid = RxList<BillByStatusModel>([]);
  final billingPaided = RxList<BillByStatusModel>([]);

  @override
  void onInit() {
    tabController = TabController(length: tabs.length, vsync: this);

    tabController.addListener(() {
      if (tabController.indexIsChanging) {
        selectedTab.value = tabController.index;
      }
    });

    fetchBillings();
    super.onInit();
  }

  fetchBillings() async {
    isLoadingData.value = LoadingType.LOADING;
    await Future.wait([
      fetchBillingUnpain(),
      fetchBillingPaid(),
    ]);
    isLoadingData.value = LoadingType.LOADED;
  }

  // UnPaid Status: 1
  Future<void> fetchBillingUnpain() async {
    final rq = await BillingRepoImpl().getBillByStatus(status: 1);
    if (rq.isSuccess() && rq.data != null) {
      billingUnpaid.value = rq.data!;
    } else {
      billingUnpaid.value = [];
    }
  }

  // UnPaid Status: 2
  Future<void> fetchBillingPaid() async {
    final rq = await BillingRepoImpl().getBillByStatus(status: 2);
    if (rq.isSuccess() && rq.data != null) {
      billingPaided.value = rq.data!;
    } else {
      billingPaided.value = [];
    }
  }

  onNavBillInfo(BillByStatusModel bill) {
    Get.toNamed(AppRoutes.billInfo, arguments: {
      'bill': bill,
    });
  }
  
}
