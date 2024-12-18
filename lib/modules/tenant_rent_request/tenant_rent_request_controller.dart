import 'package:get/get.dart';
import 'package:smart_rent/core/routes/app_routes.dart';

class TenantRentRequestController extends GetxController {
  late int roomID;
  @override
  void onInit() {
    final args = Get.arguments;
    if (args != null) {
      roomID = args['room_id'];
    }
    super.onInit();
  }

  onNavTenantSentRentRequest() {
    Get.toNamed(AppRoutes.tenantSentRentRequest, arguments: {
      'room_id': roomID,
    });
  }
}
