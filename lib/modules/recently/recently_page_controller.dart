import 'package:get/get.dart';
import 'package:smart_rent/core/app/app_storage.dart';
import 'package:smart_rent/core/enums/loading_type.dart';
import 'package:smart_rent/core/model/room/room_model.dart';
import 'package:smart_rent/core/repositories/room/room_repo_impl.dart';
import 'package:smart_rent/modules/recently/views/widgets/recently_dialog_widget.dart';

class RecentlyRoomController extends GetxController {
  final isLoadingType = LoadingType.INIT.obs;
  final listRoom = Rx<List<RoomModel>>([]);
  @override
  void onInit() {
    getListRoom();
    super.onInit();
  }

  Future<void> getListRoom() async {
    listRoom.value = [];
    isLoadingType(LoadingType.LOADING);
    final recentRoom = await AppStorage.getRecentRoom();
    await Future.wait([
      for (final id in recentRoom) getRoomById(id),
    ]);
    isLoadingType(LoadingType.LOADED);
  }

  Future<void> getRoomById(int id) async {
    final rq = await RoomRepoImpl().getRoomById(id: id);
    if (rq.isSuccess()) {
      listRoom.value.add(rq.data!);
    }
  }

  Future<void> clearList() async {
    AppStorage.clearRecentRoom();
    listRoom.value = [];
  }

  Future<void> pullRefresh() async {
    // why use freshNumbers final? https://stackoverflow.com/a/52992836/2301224
  }

  onDeleteCache() {
    Get.dialog(
      RecentlyDialogWidget(
        onConfirm: () {
          clearList();
        },
      ),
    );
  }
}
