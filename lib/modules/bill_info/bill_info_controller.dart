import 'package:get/get.dart';
import 'package:smart_rent/core/enums/loading_type.dart';
import 'package:smart_rent/core/model/billing/bill_by_id_model.dart';
import 'package:smart_rent/core/model/billing/bill_by_status_model.dart';
import 'package:smart_rent/core/repositories/billing/billing_repo_impl.dart';
import 'package:smart_rent/core/routes/app_routes.dart';

class BillInfoController extends GetxController {
  BillByStatusModel? billByStatusModel;
  final isLoadingData = LoadingType.INIT.obs;
  final billInfo = Rxn<BillByIdModel>();

  @override
  void onInit() {
    final args = Get.arguments;
    if (args != null) {
      if (args is Map<String, dynamic>) {
        billByStatusModel = args['bill'];
        fetchInfo(billByStatusModel!.id!);
      } else if (args is int) {
        fetchInfo(args);
      } else {
        Get.back();
      }
    } else {
      Get.back();
    }
    super.onInit();
  }

  fetchInfo(int id) async {
    isLoadingData.value = LoadingType.LOADING;
    final rq =
        await BillingRepoImpl().getBillByID(billID: id);
    if (rq.isSuccess() && rq.data != null) {
      billInfo.value = rq.data!;
      isLoadingData.value = LoadingType.LOADED;
    } else {
      isLoadingData.value = LoadingType.ERROR;
    }
  }

  onNavPaymentDeposit() {
    Get.toNamed(AppRoutes.paymentDeposit, arguments: {
      'bill': billInfo.value,
      'type': 'bill'
    });
  }
}
