import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_rent/core/model/room/room.dart';
import 'package:smart_rent/core/values/KEY_VALUE.dart';

class RecentlyViewController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late SharedPreferences prefs;

  var isLoading = false.obs;
  RxList<Room> listRoom = <Room>[].obs;

  @override
  void onInit() {
    super.onInit();
    getListRoom();
  }

  Future<void> getListRoom() async {
    prefs = await SharedPreferences.getInstance();
    isLoading.value = true;
    update();
    try {
      final List<String> items =
          prefs.getStringList(KeyValue.KEY_ROOM_LIST_RECENTLY) ?? [];
      for (var i in items) {
        final querySnapshot = await firestore
            .collection(KeyValue.KEY_COLLECTION_ROOM)
            .where('id', isEqualTo: i)
            .get();
        List<Room> listRecent = querySnapshot.docs
            .map(
              (e) => Room.fromJson(
                e.data(),
              ),
            )
            .toList();
        listRoom.value.add(listRecent[0]);
      }
      // final querySnapshot =
      //     await firestore.collection(KeyValue.KEY_COLLECTION_ROOM).get();
      // listRoom.value = querySnapshot.docs
      //     .map(
      //       (e) => Room.fromJson(
      //         e.data(),
      //       ),
      //     )
      //     .toList();
      update();
      isLoading.value = false;
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> clearList() async {
    await prefs.setStringList(KeyValue.KEY_ROOM_LIST_RECENTLY, []);
    listRoom.value.clear();
  }

  Future<void> pullRefresh() async {
    // why use freshNumbers var? https://stackoverflow.com/a/52992836/2301224
  }
}
