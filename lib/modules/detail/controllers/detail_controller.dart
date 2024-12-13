import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/model/account/Account.dart';
import '../../../core/model/room/room.dart';
import '../../../core/values/KEY_VALUE.dart';

class DetailAgrument {
  final Room room;
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
  late Room room;
  late bool isRequestRented;
  late bool isRequestReturnRent;
  late bool isHandleRequestReturnRoom;
  late bool isHandleRentRoom;
  late bool isRenting;
  final maximumPreivewList = 3;
  String? notificationId;
  var owner = Rx<Account?>(null);

  Rx<int> activeImageIdx = 0.obs;
  late SharedPreferences prefs;

  final arg = Get.arguments;

  @override
  void onInit() async {
    if (arg is DetailAgrument) {
      room = (arg as DetailAgrument).room;

      isRequestRented = (arg as DetailAgrument).isRequestRented;
      isRequestReturnRent = (arg as DetailAgrument).isRequestReturnRent;
      isHandleRequestReturnRoom =
          (arg as DetailAgrument).isHandleRequestReturnRoom;
      isHandleRentRoom = (arg as DetailAgrument).isHandleRentRoom;
      isRenting = (arg as DetailAgrument).isRenting;
    }
    super.onInit();
  }

  setActiveImageIdx(int value) {
    activeImageIdx.value = value;
  }

  // @override
  // void onInit() async {
  //   await getLatLng();
  //   getOwner();
  //   setRoomRecently();
  //   super.onInit();
  // }

  // Future<LatLng> getLatLng() async {
  //   LatLng result = const LatLng(0, 0);
  //   try {
  //     List<Location> locations = await locationFromAddress(room!.address![0]);
  //     result = LatLng(locations[0].latitude, locations[0].longitude);
  //   } catch (e) {
  //     print(e.toString());
  //   }
  //   return result;
  // }

  String getCapacity() {
    return '';
  }

  String getStatus() {
    return room.isRent! ? "Hết" : "Còn";
  }

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
    String formattedNumber = room.totalPrice.toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match match) => '${match[1]}.',
        );
    return '$formattedNumber ₫';
  }

  void getOwner() async {
    owner.value = const Account(
        phoneNumber: 'phoneNumber',
        uid: 'uid',
        photoUrl: 'photoUrl',
        username: 'username',
        address: 'address',
        sex: true,
        age: 40,
        dateOfBirth: 'dateOfBirth',
        dateOfCreate: 'dateOfCreate');
  }

  Future<void> setRoomRecently() async {
    prefs = await SharedPreferences.getInstance();
    final List<String> items =
        prefs.getStringList(KeyValue.KEY_ROOM_LIST_RECENTLY) ?? [];

    if (!items.contains(room.id)) {
      items.insert(0, '${room.id}');
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
}
