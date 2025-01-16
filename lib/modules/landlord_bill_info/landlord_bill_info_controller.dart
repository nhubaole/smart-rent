import 'package:get/get.dart';
import 'package:smart_rent/core/enums/loading_type.dart';
import 'package:smart_rent/core/model/billing/bill_by_id_model.dart';
import 'package:smart_rent/core/model/billing/bill_by_month_and_user_model.dart';
import 'package:smart_rent/core/repositories/billing/billing_repo_impl.dart';

class LandlordBillInfoController extends GetxController {
  BillByIdModel? billByIdModel;
  final period = Rxn<DateTime>();
  late BillByMonthAndUserItemModel billByMonthAndUserItemModel;

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
      billByMonthAndUserItemModel = args['selected_bill'];
      period.value = args['period'];
      fetchBillById();
    } else {
      Get.back();
    }
    super.onInit();
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
}
