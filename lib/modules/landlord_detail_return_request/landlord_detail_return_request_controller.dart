// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:get/get.dart';
import 'package:smart_rent/core/app/app_manager.dart';
import 'package:smart_rent/core/enums/loading_type.dart';

import 'package:smart_rent/core/model/return_request/return_request_by_id_model.dart';
import 'package:smart_rent/core/model/user/user_model.dart';
import 'package:smart_rent/core/repositories/return_request/return_request_repo_impl.dart';
import 'package:smart_rent/core/routes/app_routes.dart';
import 'package:smart_rent/core/widget/alert_snackbar.dart';
import 'package:smart_rent/core/widget/overlay_loading.dart';

class NavNotiReturnRequest {
  ReturnRequestByIdModel? returnRequestByIdModel;
  int? returnRequestID;
  NavNotiReturnRequest({
    this.returnRequestByIdModel,
    this.returnRequestID,
  });
}

class LandlordDetailReturnRequestController extends GetxController {
  ReturnRequestByIdModel? returnRequestByIdModel;
  int? returnRequestID;

  final AppManager appManager = AppManager();
  final isLoadingType = LoadingType.INIT.obs;

  UserModel get user => appManager.currentUser!;
  bool get isLandlord => user.role == 1;

  @override
  void onInit() {
    final args = Get.arguments;
    if (args != null) {
      if (args is NavNotiReturnRequest) {
        returnRequestID = args.returnRequestID;
        fetchData();
      }
    } else {
      Get.back();
    }
    super.onInit();
  }

  fetchData() async {
    isLoadingType.value = LoadingType.LOADING;
    if (returnRequestID == null) return;
    final rq =
        await ReturnRequestRepoImpl().getReturnRequestById(returnRequestID!);
    if (rq.isSuccess()) {
      returnRequestByIdModel = rq.data;
      isLoadingType.value = LoadingType.LOADED;
    } else {
      isLoadingType.value = LoadingType.ERROR;
    }
  }

  onConfirm() async {
    if (returnRequestByIdModel!.totalReturnDeposit! -
            returnRequestByIdModel!.deductAmount! ==
        0) {
      return;
    }
    OverlayLoading.show();
    if (returnRequestByIdModel == null) return;
    final rq =
        await ReturnRequestRepoImpl().confirmReturnRequest(returnRequestID!);
    OverlayLoading.hide();
    if (rq.isSuccess()) {
      if (rq.data == true) {
        Get.toNamed(
          AppRoutes.landlordPaymentDeposit,
          arguments: returnRequestByIdModel,
        );
      }
    } else {
      AlertSnackbar.show(
        title: 'Xảy ra lỗi',
        message: 'Vui lòng thử lại',
        isError: true,
      );
    }
  }
}
