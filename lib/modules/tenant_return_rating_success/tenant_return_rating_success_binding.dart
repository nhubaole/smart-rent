import 'package:get/get.dart';
import 'package:smart_rent/modules/tenant_return_rating_success/tenant_return_rating_success_controller.dart';

class TenantReturnRatingSuccessBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TenantReturnRatingSuccessController());
  }
}
