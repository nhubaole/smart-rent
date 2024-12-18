import 'package:get/get.dart';
import 'package:smart_rent/core/routes/app_routes.dart';

class PaymentSuccessController extends GetxController {
  late int paymentId;

  @override
  void onInit() {
    final args = Get.arguments;
    if (args != null && args is Map<String, dynamic>) {
      paymentId = args['payment_id'];
    } else {
      Get.back();
    }
    super.onInit();
  }

  onBackHome() {
    Get.until(
      (route) => route.settings.name == AppRoutes.root,
    );
  }

  onNavPaymentDetail() {
    Get.offNamedUntil(
      AppRoutes.paymentDetail,
      (route) => route.settings.name == AppRoutes.root,
      arguments: {
        'payment_id': paymentId,
      },
    );
  }
}
