import 'package:get/get.dart';
import 'package:smart_rent/core/enums/loading_type.dart';
import 'package:smart_rent/core/model/return_request/return_request_by_id_model.dart';
import 'package:smart_rent/core/repositories/payment/payment_repo_impl.dart';
import 'package:smart_rent/core/routes/app_routes.dart';
import 'package:smart_rent/core/widget/alert_snackbar.dart';
import 'package:smart_rent/core/widget/overlay_loading.dart';

class LandlordPaymentDepositController extends GetxController {
  ReturnRequestByIdModel? returnRequestByIdModel;
  final isLoadingData = LoadingType.INIT.obs;

  @override
  void onInit() {
    final args = Get.arguments;
    if (args != null) {
      if (args is ReturnRequestByIdModel) {
        returnRequestByIdModel = args;
        isLoadingData.value = LoadingType.LOADED;
      }
    } else {
      Get.back();
    }
    super.onInit();
  }

  onNavPaymentTransferInfo() async {
    OverlayLoading.show();
    final rq = await PaymentRepoImpl().getPaymentDetailInfo(
        billID: returnRequestByIdModel!.id!, type: 'return');
    OverlayLoading.hide();
    if (rq.isSuccess()) {
      final paymentDetailInfoModel = rq.data!;
      Get.toNamed(
        AppRoutes.paymentTransferInfo,
        arguments: {
          'payment_detail_info': paymentDetailInfoModel,
          'tenant': returnRequestByIdModel!.createdUser,
        },
      );
    } else {
      AlertSnackbar.show(
        title: 'Lỗi',
        message: 'Lỗi lấy thông tin',
        isError: true,
      );
    }
  }
}
