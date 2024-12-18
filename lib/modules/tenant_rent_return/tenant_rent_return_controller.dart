// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:get/get.dart';

import 'package:smart_rent/core/routes/app_routes.dart';

class ReturnRequestArgument {
  int? returnRequestID;

  ReturnRequestArgument({
    this.returnRequestID,
  });
}

class TenantRentReturnController extends GetxController {
  ReturnRequestArgument? returnRequestArgument;
  @override
  void onInit() {
    final args = Get.arguments;
    if (args != null) {
      if (args is ReturnRequestArgument) {
        returnRequestArgument = args;
      }
    }
    super.onInit();
  }

  onNavTenantSentReturnRequest() {
    if (returnRequestArgument != null) {
      Get.toNamed(AppRoutes.tenantSentReturnRequest,
          arguments: returnRequestArgument);
    } else {
      Get.toNamed(AppRoutes.tenantSentReturnRequest);
    }
  }
}
