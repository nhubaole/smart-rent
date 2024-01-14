import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_rent/core/model/room/room.dart';
import 'package:smart_rent/core/resources/firestore_methods.dart';
import 'package:smart_rent/core/values/KEY_VALUE.dart';

class RecentlyViewController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late SharedPreferences prefs;

  var isLoading = false.obs;
  var listRoom = Rx<List<Room>>([]);
  @override
  void onInit() {
    getListRoom();
    super.onInit();
  }

  Future<void> getListRoom() async {
    prefs = await SharedPreferences.getInstance();

    try {
      isLoading.value = true;
      final List<String> items =
          prefs.getStringList(KeyValue.KEY_ROOM_LIST_RECENTLY) ?? [];
      listRoom.value = await FireStoreMethods().getListRoomFromListId(items);
      isLoading.value = false;
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
    isLoading.value = false;
  }

  Future<void> clearList() async {
    await prefs.setStringList(KeyValue.KEY_ROOM_LIST_RECENTLY, []);
    listRoom.value.clear();
  }

  Future<void> pullRefresh() async {
    // why use freshNumbers var? https://stackoverflow.com/a/52992836/2301224
  }
}
