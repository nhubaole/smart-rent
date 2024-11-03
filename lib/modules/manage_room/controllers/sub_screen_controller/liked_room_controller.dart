import 'package:get/get.dart';
import 'package:smart_rent/core/app/app_manager.dart';
import 'package:smart_rent/core/model/room/room.dart';

class LikedRoomController extends GetxController {
  var isLoading = false.obs;
  var isLoadMore = false.obs;
  var listRoom = Rx<List<Room>>([]);
  var page = Rx<int>(10);

  String get useName => AppManager.instance.fullName ?? '--';

  @override
  void onInit() {
    getListRoom(false);
    super.onInit();
  }

  Future<void> getProfile(String uid) async {
    isLoading.value = true;
    isLoading.value = false;
  }

  Future<void> getListRoom(bool isPagination) async {
    if (isPagination) {
      isLoadMore.value = true;

      isLoadMore.value = false;
    } else {
      isLoading.value = true;
      listRoom.value.clear();

      isLoading.value = false;
    }
  }
}
