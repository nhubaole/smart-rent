import 'package:get/get.dart';
import 'package:smart_rent/core/app/app_manager.dart';
import 'package:smart_rent/core/enums/loading_type.dart';
import 'package:smart_rent/core/model/rental_request/rental_request_all_model.dart';
import 'package:smart_rent/core/model/user/user_model.dart';
import 'package:smart_rent/core/repositories/rental_request/rental_request_repo_impl.dart';
import 'package:smart_rent/core/routes/app_routes.dart';


class RequestRentController extends GetxController {
  List<RentalRequestAllModel>? rentalRequests;

  final AppManager appManager = AppManager.instance;

  final isLoadingData = LoadingType.INIT.obs;

  UserModel get userModel => appManager.currentUser!;

  bool get isLandlord => userModel.role == 1;

  @override
  void onInit() {
    fetchRequestRent();
    super.onInit();
  }

  fetchRequestRent() async {
    isLoadingData.value = LoadingType.LOADING;
    final rq = await RentalRequestRepoImpl().getAllRentalRequest();
    if (rq.isSuccess()) {
      rentalRequests = rq.data!;
      isLoadingData.value = LoadingType.LOADED;

    } else {
      isLoadingData.value = LoadingType.ERROR;
    }
  }

  onDetailRequestRoomV2(RentalRequestAllModel rentalRequest) {
    Get.toNamed(AppRoutes.detailRequestRoomV2, arguments: {
      'rental_request': rentalRequest,
    });
  }
}
