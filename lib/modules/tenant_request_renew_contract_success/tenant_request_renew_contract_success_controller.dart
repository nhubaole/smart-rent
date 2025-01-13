import 'package:get/get.dart';
import 'package:smart_rent/core/routes/app_routes.dart';
import 'package:smart_rent/core/widget/alert_snackbar.dart';
import 'package:smart_rent/modules/contract_sign/contract_sign_controller.dart';

class TenantRequestRenewContractSuccessController extends GetxController {
  RenewContractArgument? renewContractArgument;

  @override
  void onInit() {
    final args = Get.arguments;
    if (args != null) {
      if (args is RenewContractArgument) {
        renewContractArgument = args;
      }
    } else {
      Get.back();
      AlertSnackbar.show(title: 'Error', message: 'Error param', isError: true);
    }
    super.onInit();
  }

  void onBackHome() {
    Get.until(
      (route) => route.settings.name == AppRoutes.root,
    );
  }
}
