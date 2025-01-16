import 'package:get/get.dart';
import 'package:smart_rent/core/enums/loading_type.dart';
import 'package:smart_rent/core/model/rental_request/all_process_tracking_model.dart';
import 'package:smart_rent/core/model/rental_request/process_tracking_by_id_model.dart';
import 'package:smart_rent/core/repositories/rental_request/rental_request_repo_impl.dart';

class TrackRentalProcessController extends GetxController {
  final isFetchingDetailProcessTracking = LoadingType.INIT.obs;
  final processTrackings = <ProcessTrackingByIdModel>[].obs;

  AllProcessTrackingModel? processTrackingModel;

  @override
  void onInit() {
    final args = Get.arguments;
    if (args != null) {
      if (args is AllProcessTrackingModel) {
        processTrackingModel = args;
        fetchDetailProcess();
      } else {
        Get.back();
      }
    } else {
      Get.back();
    }
    super.onInit();
  }

  fetchDetailProcess() async {
    isFetchingDetailProcessTracking(LoadingType.LOADING);
    final rq = await RentalRequestRepoImpl()
        .getDetailProcessTrackingByID(id: processTrackingModel!.id!);
    if (rq.isSuccess()) {
      processTrackings(rq.data!);
      isFetchingDetailProcessTracking(LoadingType.LOADED);
    } else {
      isFetchingDetailProcessTracking(LoadingType.ERROR);
    }
  }
}
