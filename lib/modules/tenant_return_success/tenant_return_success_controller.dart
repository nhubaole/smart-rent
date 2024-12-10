import 'package:get/get.dart';
import 'package:smart_rent/core/routes/app_routes.dart';

class TenantReturnSuccessController extends GetxController {
  onDoItLater() {
    Get.until(
      (route) => route.settings.name == AppRoutes.root,
    );
  }

  onNavReview() {
    Get.offNamedUntil(AppRoutes.tenantReturnRating,
        (route) => route.settings.name == AppRoutes.root);
  }
}
