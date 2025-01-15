import 'dart:developer';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_rent/core/app/app_manager.dart';
import 'package:smart_rent/core/enums/loading_type.dart';
import 'package:smart_rent/core/helper/helper.dart';
import 'package:smart_rent/core/model/rating/rating_by_id_room_model.dart';
import 'package:smart_rent/core/model/room/room_model.dart';
import 'package:smart_rent/core/model/user/user_model.dart';
import 'package:smart_rent/core/repositories/rating/rating_repo_impl.dart';
import 'package:smart_rent/core/repositories/room/room_repo_impl.dart';
import 'package:smart_rent/core/routes/app_routes.dart';
import 'package:smart_rent/core/widget/alert_snackbar.dart';
import '../../../core/values/KEY_VALUE.dart';

class DetailAgrument {
  final RoomModel room;
  final bool isRequestRented;
  final bool isRequestReturnRent;
  final bool isHandleRequestReturnRoom;
  final bool isHandleRentRoom;
  final bool isRenting;
  String? notificationId;

  DetailAgrument({
    required this.room,
    required this.isRequestRented,
    required this.isRequestReturnRent,
    required this.isHandleRequestReturnRoom,
    required this.isHandleRentRoom,
    required this.isRenting,
  });
}

class DetailController extends GetxController {
  RoomModel? room;
  RatingByIdRoomModel? rating;
  List<RoomModel>? suggestRooms = [];
  final maximumPreivewList = 3;
  final activeImageIdx = 0.obs;

  late SharedPreferences prefs;

  UserModel get userModel => room!.owner as UserModel;

  String get getCapacity => room!.capacity.toString();

  String get getStatus => room!.isRent! ? "Hết" : "Còn";

  String get ratingOveview => rating!.avgRating! > 4
      ? 'Tốt'
      : rating!.avgRating! > 3
          ? 'Khá'
          : 'Trung bình';

  UserModel get owner => room!.owner as UserModel;

  final isLoadingData = LoadingType.INIT.obs;

  final isLoadingSuggestRoom = LoadingType.INIT.obs;

  final isLiked = false.obs;


  // TODO: ONLY TESTING
  bool get isOwner =>
      (room!.owner! is UserModel
          ? ((room!.owner! as UserModel).id!)
          : (room!.owner! as int)) ==
      AppManager().currentUser!.id!;

  bool get canRent =>
      !room!.isRent! && !isOwner && AppManager().currentUser!.role == 0;
  
  @override
  void onInit() async {
    initData(null);
    super.onInit();
  }

  initData(Map<String, dynamic>? args) async {
    isLoadingData.value = LoadingType.INIT;
    isLoadingSuggestRoom.value = LoadingType.INIT;
    final arg = args ?? Get.arguments;
    if (arg != null) {
      final rq = await RoomRepoImpl().getRoomById(id: arg['id']);
      if (rq.isSuccess()) {
        room = rq.data!;
        rating = await fetchRatingByIdRoom(room!.id);
        // rating = await fetchRatingByIdRoom(48);
        onLikeAction();
        isLoadingData.value = LoadingType.LOADED;
        // room!.roomNumbers?.forEach((key, value) async {
        //   final roomSuggest = await getRoomSuggest(value as int);
        //   if (roomSuggest != null) {
        //     suggestRooms!.add(roomSuggest);
        //   }
        // });
        await Future.forEach(room!.roomNumbers!.values, (element) async {
          if (element != room!.id) {
            final roomSuggest = await getRoomSuggest(element as int);
            if (roomSuggest != null) {
              suggestRooms!.add(roomSuggest);
            }
          }
        });
        isLoadingSuggestRoom.value = LoadingType.LOADED;
      } else {
        isLoadingData.value = LoadingType.ERROR;
      }
    }
  }

  Future<RatingByIdRoomModel?> fetchRatingByIdRoom(int id) async {
    final rq = await RatingRepoImpl().getRatingByIdRoom(id: id);
    if (rq.isSuccess()) {
      return rq.data!;
    }
    return null;
  }

  reselectRoom(int id) async {
    if (id == room!.id) return;
    isLoadingData.value = LoadingType.INIT;
    isLoadingSuggestRoom.value = LoadingType.INIT;
    final rq = await RoomRepoImpl().getRoomById(id: id);
    if (rq.isSuccess()) {
      room = rq.data!;
      isLoadingData.value = LoadingType.LOADED;
      room!.roomNumbers?.forEach((key, value) async {
        final roomSuggest = await getRoomSuggest(125);
        if (roomSuggest != null) {
          suggestRooms!.add(roomSuggest);
        }
      });
      isLoadingSuggestRoom.value = LoadingType.LOADED;
    } else {
      isLoadingData.value = LoadingType.ERROR;
    }
  }

  Future<RoomModel?> getRoomSuggest(int id) async {
    final rq = await RoomRepoImpl().getRoomById(id: id);
    if (rq.isSuccess()) {
      return rq.data;
    }
    return null;
  }
  

  setActiveImageIdx(int value) {
    activeImageIdx.value = value;
  }

  onChatOwner() {

  }

  onCallOwner() {}

  String priceFormatter(int price) {
    if (price <= 0) {
      return "Miễn phí";
    } else if (price < 1000) {
      return "$price₫";
    } else if (price >= 1000 && price < 1000000) {
      return "${price / 1000}k";
    } else {
      return "${price / 1000000}tr";
    }
  }

  String priceFormatterFull() {
    String formattedNumber = room!.totalPrice.toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match match) => '${match[1]}.',
        );
    return '$formattedNumber ₫';
  }

 
  Future<void> setRoomRecently() async {
    prefs = await SharedPreferences.getInstance();
    final List<String> items =
        prefs.getStringList(KeyValue.KEY_ROOM_LIST_RECENTLY) ?? [];

    if (!items.contains(room!.id)) {
      items.insert(0, '${room!.id}');
    }

    await prefs.setStringList(KeyValue.KEY_ROOM_LIST_RECENTLY, items);
    // print("items.toString() = " + items.toString());
  }

  Future<void> sendNotificationReturnRentRoom(
    String idRoom,
    String senderId,
    String receiverId,
    String title,
    String body,
    bool sound,
    String imgUrl,
    String contentType,
  ) async {}


  onOpenMap() async {
    try {
      await Helper.openGoogleMapsByAddress(room!.addresses!.join(','));
    } catch (e) {
      AlertSnackbar.show(
        title: 'Lỗi mở bản đồ',
        message: 'Không thể mở bản đồ',
        isError: true,
      );
    }
  }

  onLikeAction() async {
    final isLikedValue = await RoomRepoImpl().getLikedRoom(room!.id);
    if (isLikedValue.isSuccess()) {
      isLiked.value = !isLikedValue.data!;
    }
  }

  onDeleteRoom() {}

  onEditRoom() {}

  onRentNow() {
    Get.toNamed(AppRoutes.tenantRentRequest, arguments: {
      'room_id': room!.id,
    });
  }
}


