import 'package:get/get.dart';
import 'package:smart_rent/core/app/app_manager.dart';
import 'package:smart_rent/core/enums/loading_type.dart';
import 'package:smart_rent/core/model/room/room_model.dart';
import 'package:smart_rent/core/repositories/room/room_repo_impl.dart';


class WaitApproveRoomController extends GetxController {
  final isLoadMore = false.obs;
  final listRoom = Rx<List<RoomModel>>([]);

  final statusLoading = LoadingType.INIT.obs;

  String get useName => AppManager.instance.fullName ?? '--';

  @override
  void onInit() {
    _initData();
    super.onInit();
  }

  _initData() async {
    await getListRoom();
  }

  Future<void> getListRoom() async {
    statusLoading.value = LoadingType.LOADING;
    final rq = await RoomRepoImpl().getRoomsByStatus(0);
    if (rq.isSuccess()) {
      listRoom.value = rq.data!;
      statusLoading.value = LoadingType.LOADED;
    } else {
      statusLoading.value = LoadingType.ERROR;
    }
  }
}
