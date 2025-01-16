import 'package:get/get.dart';
import 'package:smart_rent/core/app/app_manager.dart';
import 'package:smart_rent/core/enums/loading_type.dart';
import 'package:smart_rent/core/enums/request_room_status.dart';
import 'package:smart_rent/core/model/rental_request/rental_request_all_model.dart';
import 'package:smart_rent/core/model/rental_request/rental_request_by_id_model.dart';
import 'package:smart_rent/core/model/user/user_model.dart';
import 'package:smart_rent/core/repositories/rental_request/rental_request_repo_impl.dart';
import 'package:smart_rent/core/routes/app_routes.dart';
import 'package:smart_rent/core/widget/alert_snackbar.dart';
import 'package:smart_rent/core/widget/overlay_loading.dart';

class DetailRequestController extends GetxController {
  RentalRequestByIdModel? rentalRequestById;
  RequestInfo? requestInfo;

  final AppManager appManager = AppManager.instance;
  final isLoadingData = LoadingType.INIT.obs;

  UserModel get userModel => appManager.currentUser!;
  bool get isLandlord => userModel.role == 1;
  RequestRoomStatus get requestStatus =>
      RequestRoomStatusExtension.fromInt(rentalRequestById!.status!);

  
  @override
  void onInit() {
    final args = Get.arguments;
    if (args != null) {
      if (args is RequestInfo) {
        requestInfo = args;
        fetchRentalRequestById(requestInfo!);
      } else {
        Get.back();
      }
    } else {
      Get.back();
    }
    super.onInit();
  }

  fetchRentalRequestById(RequestInfo requestInfo) async {
    isLoadingData.value = LoadingType.LOADING;
    final rq =
        await RentalRequestRepoImpl().getRentalRequestById(requestInfo.id!);
    if (rq.isSuccess()) {
      rentalRequestById = rq.data!;
      isLoadingData.value = LoadingType.LOADED;
    } else {
      isLoadingData.value = LoadingType.ERROR;
      AlertSnackbar.show(
        title: 'Xảy ra lỗi',
        message:
            'Đã xảy ra lỗi trong quá trình xử lý yêu cầu. Vui lòng thử lại sau.',
        isError: false,
      );
    }
  }

  onApproveRequest() async {
    OverlayLoading.show();
    final rq =
        await RentalRequestRepoImpl()
        .approveRentalRequest(rentalRequestById!.id!);
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
        await RentalRequestRepoImpl()
        .declineRentalRequest(rentalRequestById!.id!);
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
    Get.toNamed(AppRoutes.landlordContractCreate, arguments: {
      'rental_request_by_id': rentalRequestById,
    });
  }

  tenantCancelRequest() async {
    OverlayLoading.show();
    final rq = await RentalRequestRepoImpl()
        .declineRentalRequest(rentalRequestById!.id!);
    if (rq.isSuccess()) {
      OverlayLoading.hide();
      AlertSnackbar.show(
        title: 'Hủy yêu cầu thành công',
        message: 'Bạn đã Hủy yêu cầu thành công',
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

  tenantEditRequest() {
    Get.toNamed(AppRoutes.tenantSentRentRequest, arguments: {
      'room_id': rentalRequestById!.id!,
    });
  }
}
