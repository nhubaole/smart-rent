import 'package:get/get.dart';
import 'package:smart_rent/core/routes/app_routes.dart';

class ContractDetailController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  onContractSign() {
    Get.toNamed(AppRoutes.contractSign);
  }
}
