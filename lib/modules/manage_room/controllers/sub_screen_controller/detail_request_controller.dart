import 'package:get/get.dart';
import 'package:smart_rent/core/app/app_manager.dart';
import 'package:smart_rent/core/model/rental_request/rental_request_all_model.dart';
import 'package:smart_rent/core/model/user/user_model.dart';
import 'package:smart_rent/core/repositories/rental_request/rental_request_repo_impl.dart';
import 'package:smart_rent/core/routes/app_routes.dart';
import 'package:smart_rent/core/widget/alert_snackbar.dart';
import 'package:smart_rent/core/widget/overlay_loading.dart';

class DetailRequestController extends GetxController {
  final AppManager appManager = AppManager.instance;

  late RentalRequestAllModel rentalRequest;

  UserModel get userModel => appManager.currentUser!;
  bool get isLandlord => userModel.role == 1;

  @override
  void onInit() {
    final args = Get.arguments;
    if (args != null) {
      rentalRequest = args['rental_request'];
    } else {
      Get.back();
    }
    super.onInit();
  }

  onApproveRequest() async {
    OverlayLoading.show();
    final rq =
        await RentalRequestRepoImpl().approveRentalRequest(rentalRequest.id!);
    if (rq.isSuccess()) {
      OverlayLoading.hide();
      AlertSnackbar.show(
        title: 'Chấp nhận yêu cầu thành công',
        message:
            'Bạn đã tiếp nhận yêu cầu thành công, hãy tiếp tục bước tiếp theo',
        isError: false,
      );
      // TODO: nav to messgae
      Get.until((route) => route.settings.name == AppRoutes.root);
    } else {
      OverlayLoading.hide();
      AlertSnackbar.show(
        title: 'Xảy ra lỗi',
        message:
            'Đã xảy ra lỗi trong quá trình xử lý yêu cầu. Vui lòng thử lại sau.',
        isError: false,
      );
    }
  }

  onRejectRequest() async {
    OverlayLoading.show();
    final rq =
        await RentalRequestRepoImpl().declineRentalRequest(rentalRequest.id!);
    if (rq.isSuccess()) {
      OverlayLoading.hide();
      AlertSnackbar.show(
        title: 'Từ chối yêu cầu thành công',
        message:
            'Bạn đã từ chối yêu cầu thành công, hãy tiếp tục bước tiếp theo',
        isError: false,
      );
      // TODO: nav to messgae
      Get.until((route) => route.settings.name == AppRoutes.root);
    } else {
      OverlayLoading.hide();
      AlertSnackbar.show(
        title: 'Xảy ra lỗi',
        message:
            'Đã xảy ra lỗi trong quá trình xử lý yêu cầu. Vui lòng thử lại sau.',
        isError: false,
      );
    }
  }

  void onNavLandlordContractCreate() {
    Get.toNamed(AppRoutes.landlordContractCreate);
  }
}
