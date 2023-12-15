import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_rent/core/enums/gender.dart';

import '../../../core/model/account/Account.dart';
import '../../../core/model/room/room.dart';
import '../../../core/values/KEY_VALUE.dart';

class DetailController extends GetxController {
  Room? room;
  var owner = Rx<Account?>(null);

  Rx<int> activeImageIdx = 0.obs;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late SharedPreferences prefs;

  String getCapacity() {
    return room?.gender == Gender.ALL
        ? "${room?.capacity} Nam/Nữ"
        : "${room?.capacity} ${room?.gender.getNameGender()}";
  }

  String getStatus() {
    return room!.isRented ? "Hết" : "Còn";
  }

  String priceFormatter(int price) {
    if (price <= 0) {
      return "Miễn phí";
    } else if (price < 1000) {
      return "${price}₫";
    } else if (price >= 1000 && price < 1000000) {
      return "${price / 1000}k";
    } else {
      return "${price / 1000000}tr";
    }
  }

  String priceFormatterFull() {
    String formattedNumber = room!.price.toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match match) => '${match[1]}.',
        );
    return formattedNumber + " ₫";
  }

  void getOwner() async {
    final snapshot = await _firestore
        .collection(KeyValue.KEY_COLLECTION_ACCOUNT)
        .doc(room!.createdByUid)
        .get();

    print(snapshot.data().toString());

    Account account = Account.fromJson(snapshot.data()!);
    owner.value = account;
  }

  Future<void> setRoomRecently() async {
    prefs = await SharedPreferences.getInstance();
    final List<String> items =
        prefs.getStringList(KeyValue.KEY_ROOM_LIST_RECENTLY) ?? [];

    if (!items.contains(room!.id)) {
      items.insert(0, room!.id);
    }

    await prefs.setStringList(KeyValue.KEY_ROOM_LIST_RECENTLY, items);
    print("items.toString() = " + items.toString());
  }
}
