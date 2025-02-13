import 'package:get/get.dart';
import 'package:smart_rent/core/enums/loading_type.dart';
import 'package:smart_rent/core/model/user/user_model.dart';
import 'package:smart_rent/core/repositories/room/room_repo_impl.dart';
import 'package:smart_rent/core/repositories/user/user_repo_iml.dart';

class RatingUserController extends GetxController {
  final userModel = Rx<UserModel>(UserModel());
  final isLoading = LoadingType.INIT.obs;
  @override
  void onInit() {
    final args = Get.arguments;
    if (args != null && args is Map<String, dynamic>) {
      final userID = args['user_id'] as int;
      fetchUserModel(userID);
    } else {
      Get.back();
    }
    super.onInit();
  }

  bool get isVerifiedID =>
      userModel.value.privteKeyHex != null &&
      userModel.value.walletAddress != null;

  bool get isVerifiedPhone => userModel.value.phoneNumber != null;

  fetchUserModel(int userID) async {
    isLoading.value = LoadingType.LOADING;
    final rq = await UserRepoIml().getUserById(id: userID);
    if (rq.isSuccess()) {
      userModel.value = rq.data!;
      final rqRooms = await RoomRepoImpl().getByOwner();
      if (rqRooms.isSuccess()) {
        userModel.value.rooms = rqRooms.data;
      } else {
        userModel.value.rooms = [];
      }
      isLoading.value = LoadingType.LOADED;
    } else {
      isLoading.value = LoadingType.ERROR;
    }
  }

  fetchListRoomOwner() {}
}
