import 'package:get/get.dart';
import 'package:smart_rent/core/app/app_manager.dart';
import 'package:smart_rent/core/enums/loading_type.dart';
import 'package:smart_rent/core/model/payment/payment_all_model.dart';
import 'package:smart_rent/core/model/user/user_model.dart';
import 'package:smart_rent/core/repositories/payment/payment_repo_impl.dart';
import 'package:smart_rent/core/routes/app_routes.dart';

class TransactionHistoryController extends GetxController {
  List<PaymentAllModel>? historyTransactions;
  final AppManager appManager = AppManager.instance;

  final isLoadingData = LoadingType.INIT.obs;

  UserModel get userModel => appManager.currentUser!;

  bool get isLandlord => userModel.role == 1;

  @override
  void onInit() {
    fetchTransactions();
    super.onInit();
  }

  fetchTransactions() async {
    isLoadingData.value = LoadingType.INIT;
    final rq = await PaymentRepoImpl().getAllPayment();
    if (rq.isSuccess()) {
      historyTransactions = rq.data!;
      isLoadingData.value = LoadingType.LOADED;
    } else {
      isLoadingData.value = LoadingType.ERROR;
    }
  }

  onNavPaymentDetail(PaymentAllModel payment) {
    Get.toNamed(AppRoutes.paymentDetail, arguments: payment);
  }
}
