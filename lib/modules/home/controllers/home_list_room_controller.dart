import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:smart_rent/core/model/room/room.dart';
import 'package:smart_rent/core/resources/firestore_methods.dart';

class HomeListRoomController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  var isLoading = Rx<bool>(false);
  var isLoadMore = Rx<bool>(false);
  var page = Rx<int>(10);
  var listRoom = Rx<List<Room>>([]);

  Future<void> getListRoom(bool isPagination) async {
    if (isPagination) {
      isLoadMore.value = true;
      listRoom.value =
          await FireStoreMethods().getListRoomForHome(page.value += 10);
      isLoadMore.value = false;
    } else {
      isLoading.value = true;
      listRoom.value = await FireStoreMethods().getListRoomForHome(page.value);
      isLoading.value = false;
    }
  }
}
