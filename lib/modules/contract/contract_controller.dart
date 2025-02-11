import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_rent/core/app/app_manager.dart';
import 'package:smart_rent/core/enums/loading_type.dart';
import 'package:smart_rent/core/model/contract/contract_by_status_model.dart';
import 'package:smart_rent/core/model/contract/template_model.dart';
import 'package:smart_rent/core/model/user/user_model.dart';
import 'package:smart_rent/core/repositories/contract/contract_repo_impl.dart';

class ContractController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final tabs = [
    'awaiting'.tr,
    'active'.tr,
    'expired'.tr,
  ];
  final selectedTab = 0.obs;

  late TabController tabController;

  final loadingPendingContracts = LoadingType.INIT.obs;
  final loadingActiveContracts = LoadingType.INIT.obs;
  final loadingExpiredContracts = LoadingType.INIT.obs;

  final pendingContracts = <ContractByStatusModel>[].obs;
  final activeContracts = <ContractByStatusModel>[].obs;
  final expiredContracts = <ContractByStatusModel>[].obs;
  final contractTemplates = <TemplateModel>[].obs;

  UserModel get currentUser => AppManager().currentUser!;
  bool get isLandlord => currentUser.role == 1;

  @override
  void onInit() {
    _initController();
    _initData();
    super.onInit();
  }

  refreshTemplateContracts() async {
    fetchContractTemplates();
  }

  _initController() {
    tabController = TabController(length: tabs.length, vsync: this);
    tabController.addListener(() {
      if (tabController.indexIsChanging) {
        selectedTab.value = tabController.index;
      }
    });
  }

  _initData() async {
    await Future.wait([
      fetchPendingContracts(),
      fetchActiveContracts(),
      fetchExpiredContracts(),
      fetchContractTemplates()
    ]);
  }

  Future<void> fetchContractTemplates() async {
    try {
      final rq = await ContractRepoImpl().getTemplatesByOwner();
      if (rq.isSuccess()) {
        contractTemplates.value = rq.data!;
      } else {
      }
    } catch (e) {
    }
  }

  Future<void> fetchPendingContracts() async {
    loadingPendingContracts.value = LoadingType.LOADING;
    try {
      final rq = await ContractRepoImpl().getContractByStatus(0);
      if (rq.isSuccess()) {
        pendingContracts.value = rq.data!;
        loadingPendingContracts.value = LoadingType.LOADED;
      } else {
        loadingPendingContracts.value = LoadingType.ERROR;
      }
    } catch (e) {
      loadingPendingContracts.value = LoadingType.ERROR;
    }
  }

  Future<void> fetchActiveContracts() async {
    loadingActiveContracts.value = LoadingType.LOADING;
    try {
      final rq = await ContractRepoImpl().getContractByStatus(1);
      if (rq.isSuccess()) {
        activeContracts.value = rq.data!;
        loadingActiveContracts.value = LoadingType.LOADED;
      } else {
        loadingActiveContracts.value = LoadingType.ERROR;
      }
    } catch (e) {
      loadingActiveContracts.value = LoadingType.ERROR;
    }
  }

  Future<void> fetchExpiredContracts() async {
    loadingExpiredContracts.value = LoadingType.LOADING;
    try {
      final rq = await ContractRepoImpl().getContractByStatus(2);
      if (rq.isSuccess()) {
        expiredContracts.value = rq.data!;
        loadingExpiredContracts.value = LoadingType.LOADED;
      } else {
        loadingExpiredContracts.value = LoadingType.ERROR;
      }
    } catch (e) {
      loadingExpiredContracts.value = LoadingType.ERROR;
    }
  }
}
