import 'package:get/get.dart';
import 'package:smart_rent/core/enums/loading_type.dart';
import 'package:smart_rent/core/model/rating/rating_by_id_room_model.dart';
import 'package:smart_rent/core/routes/app_routes.dart';

class RatingController extends GetxController {
  late RatingByIdRoomModel rating;
  final isLoadingType = LoadingType.INIT.obs;

  @override
  void onInit() {
    final args = Get.arguments;
    if (args != null && args is Map<String, dynamic>) {
      rating = args['rating'] as RatingByIdRoomModel;
    }
    super.onInit();
  }

  fetchData() {
    isLoadingType.value = LoadingType.LOADING;
    // Call API
    isLoadingType.value = LoadingType.ERROR;
  }

  onNavRatingUser() {
    Get.toNamed(AppRoutes.ratingUser, arguments: {
      'user_id': 2,
    });
  }
}
