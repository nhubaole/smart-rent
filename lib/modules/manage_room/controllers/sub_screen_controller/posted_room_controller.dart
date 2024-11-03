import 'package:get/get.dart';
import 'package:smart_rent/core/app/app_manager.dart';
import '/core/model/room/room.dart';

class PostedRoomController extends GetxController {
  var isLoading = false.obs;
  var isLoadMore = false.obs;
  var listRoom = Rx<List<Room>>([]);
  var page = Rx<int>(10);

  String get fullName => AppManager.instance.fullName ?? '--';

  @override
  void onInit() {
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
