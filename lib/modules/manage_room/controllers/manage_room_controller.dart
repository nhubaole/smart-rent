import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_rent/core/app/app_manager.dart';
import 'package:smart_rent/core/enums/loading_type.dart';
import 'package:smart_rent/core/model/rental_request/all_process_tracking_model.dart';
import 'package:smart_rent/core/model/user/user_model.dart';
import 'package:smart_rent/core/repositories/rental_request/rental_request_repo_impl.dart';
import 'package:smart_rent/core/routes/app_routes.dart';

class ManageRoomController extends GetxController {
  UserModel get user => AppManager().currentUser!;

  final processTracking = <AllProcessTrackingModel>[].obs;

  final isFetchingProcessTracking = LoadingType.INIT.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProcessTracking();
  }

  fetchProcessTracking() async {
    isFetchingProcessTracking(LoadingType.LOADING);
    final rq = await RentalRequestRepoImpl().getAllProcessTracking();
    if (rq.isSuccess()) {
      processTracking(rq.data!);
      isFetchingProcessTracking(LoadingType.LOADED);
    } else {
      isFetchingProcessTracking(LoadingType.ERROR);
    }
  }

  onNavContract() {
    if (user.role == 0) {
      Get.toNamed(AppRoutes.contract);
    } else {
      // Get.toNamed(AppRoutes.contr)
    }
  }

  void goToScreen(Widget accountDetailScreen) {
    Get.to(() => accountDetailScreen);
  }

  onDetailProcess(AllProcessTrackingModel model) {
    Get.toNamed(AppRoutes.trackRentalProcess, arguments: model);
  }
}
