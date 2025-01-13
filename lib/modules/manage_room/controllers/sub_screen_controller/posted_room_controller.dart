import 'package:get/get.dart';
import 'package:smart_rent/core/app/app_manager.dart';
import 'package:smart_rent/core/enums/loading_type.dart';
import 'package:smart_rent/core/model/room/room_model.dart';
import 'package:smart_rent/core/repositories/room/room_repo_impl.dart';


class PostedRoomController extends GetxController {
  var isLoadMore = false.obs;
  var listRoom = Rx<List<RoomModel>>([]);
  var page = Rx<int>(10);

  String get fullName => AppManager.instance.fullName ?? '--';
  final statusLoading = LoadingType.INIT.obs;
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
    final rq = await RoomRepoImpl().getByOwner();
    if (rq.isSuccess()) {
      listRoom.value = rq.data!;
      statusLoading.value = LoadingType.LOADED;
    } else {
      statusLoading.value = LoadingType.ERROR;
    }
  }
}
