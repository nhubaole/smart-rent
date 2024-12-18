import 'package:get/get.dart';
import 'package:smart_rent/core/enums/loading_type.dart';
import 'package:smart_rent/core/model/billing/bill_by_id_model.dart';
import 'package:smart_rent/core/model/payment/payment_detail_info_model.dart';
import 'package:smart_rent/core/repositories/payment/payment_repo_impl.dart';
import 'package:smart_rent/core/routes/app_routes.dart';

class PaymentDepositController extends GetxController {
  BillByIdModel? billByIdModel;
  final isLoadingData = LoadingType.INIT.obs;

  PaymentDetailInfoModel? paymentDetailInfoModel;

  @override
  void onInit() {
    final args = Get.arguments;
    if (args != null) {
      if (args is Map<String, dynamic>) {
        billByIdModel = args['bill'];
        fetchDetailInfo();
      } 
    } else {
      Get.back();
    }
    super.onInit();
  }

  fetchDetailInfo() async {
    isLoadingData.value = LoadingType.LOADING;
    final rq =
        await PaymentRepoImpl().getPaymentDetailInfo(
      billID: billByIdModel!.id!,
      type: 'bill',
    );
    if (rq.isSuccess() && rq.data != null) {
      paymentDetailInfoModel = rq.data!;
      isLoadingData.value = LoadingType.LOADED;
    } else {
      isLoadingData.value = LoadingType.ERROR;
    }
  }

  onNavPaymentTransferInfo() {
    Get.toNamed(
      AppRoutes.paymentTransferInfo,
      arguments: {
        'bill': billByIdModel,
        'payment_detail_info': paymentDetailInfoModel,
      },
    );
  }
}
