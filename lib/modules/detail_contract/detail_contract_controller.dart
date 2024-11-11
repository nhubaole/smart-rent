import 'package:get/get.dart';
import 'package:smart_rent/core/routes/app_routes.dart';

class DetailContractController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  onSignContract() {
    Get.toNamed(AppRoutes.contractSign);
  }
}
