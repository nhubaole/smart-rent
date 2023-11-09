import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:smart_rent/core/model/room/room.dart';
import 'package:smart_rent/core/values/KEY_VALUE.dart';

class RecentlyViewController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  var isLoading = false.obs;
  RxList<Room> listRoom = <Room>[].obs;

  @override
  void onInit() {
    super.onInit();
    getListRoom();
  }

  Future<void> getListRoom() async {
    isLoading.value = true;
    update();
    try {
      final querySnapshot =
          await firestore.collection(KeyValue.KEY_COLLECTION_ROOM).get();
      listRoom.value = querySnapshot.docs
          .map(
            (e) => Room.fromJson(
              e.data(),
            ),
          )
          .toList();
      update();
      isLoading.value = false;
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> pullRefresh() async {
    // why use freshNumbers var? https://stackoverflow.com/a/52992836/2301224
  }
}
