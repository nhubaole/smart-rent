import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:smart_rent/core/model/room/room.dart';
import 'package:smart_rent/core/values/key_value.dart';

class HomeListRoomController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  var isLoading = false;
  RxList<Room> listRoom = <Room>[].obs;

  Future<void> getListRoom() async {
    isLoading = true;
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
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
}
