import 'package:get/get.dart';
import 'package:smart_rent/modules/tenant_return_rating/tenant_return_rating_controller.dart';

class TenantReturnRatingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TenantReturnRatingController());
  }
}
