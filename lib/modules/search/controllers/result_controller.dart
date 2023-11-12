import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:smart_rent/core/model/room/room.dart';
import 'package:smart_rent/core/values/KEY_VALUE.dart';
import 'package:tiengviet/tiengviet.dart';

class ResultController extends GetxController {
  late String location;
  var results = Rx<List<Room>>([]);
  RxBool isLoaded = false.obs;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void setLocation(String location) {
    this.location = location;
    queryRoomByLocation();
  }

  void queryRoomByLocation() async {
    print("QUẺY: $location");
    try {
      final querySnapshot =
          await firestore.collection(KeyValue.KEY_COLLECTION_ROOM).get();
      results.value = querySnapshot.docs
          .map(
            (e) => Room.fromJson(
              e.data(),
            ),
          )
          .where((element) => TiengViet.parse(element.location.toLowerCase())
              .contains(TiengViet.parse(location.toLowerCase())))
          .toList();
      isLoaded.value = true;
      print(results.value.length);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
}
