import 'package:get/get.dart';
import 'package:smart_rent/core/model/billing/bill_by_id_model.dart';
import 'package:smart_rent/core/model/payment/payment_detail_info_model.dart';
import 'package:smart_rent/core/model/user/user_model.dart';
import 'package:smart_rent/core/routes/app_routes.dart';

class LandlordReturnSuccessController extends GetxController {
  BillByIdModel? billByIdModel;
  PaymentDetailInfoModel? paymentDetailInfoModel;
  int? paymentId;
  UserModel? tenant;

  @override
  void onInit() {
    final args = Get.arguments;
    if (args != null && args is Map<String, dynamic>) {
      billByIdModel = args['bill'];
      paymentDetailInfoModel = args['payment_detail_info'];
      paymentId = args['payment_id'];
      tenant = args['tenant'];
    } else {
      Get.back();
    }
    super.onInit();
  }

  onNavRating() async {
    Get.toNamed(AppRoutes.landlordReturnRating, arguments: {
      'bill': billByIdModel,
      'payment_detail_info': paymentDetailInfoModel,
      'payment_id': paymentId,
      'tenant': tenant,
    });
  }
}
