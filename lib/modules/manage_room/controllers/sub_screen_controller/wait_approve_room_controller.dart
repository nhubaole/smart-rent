import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:smart_rent/core/model/account/Account.dart';
import 'package:smart_rent/core/model/room/room.dart';
import 'package:smart_rent/core/resources/auth_methods.dart';
import 'package:smart_rent/core/resources/firestore_methods.dart';

class WaitApproveRoomController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  var isLoading = false.obs;
  var isLoadMore = false.obs;
  var listTicket = Rx<List<Map<String, dynamic>>>([]);
  var listRoom = Rx<List<Room>>([]);
  var profileOwner = Rx<Account?>(null);
  var page = Rx<int>(10);

  @override
  void onInit() {
    super.onInit();
    getListRoom(false);
    getProfile(FirebaseAuth.instance.currentUser!.uid);
  }

  Future<void> getProfile(String uid) async {
    isLoading.value = true;
    profileOwner.value = await AuthMethods.getUserDetails(uid);
    isLoading.value = false;
  }

  Future<void> getListRoom(bool isPagination) async {
    if (isPagination) {
      isLoadMore.value = true;
      listRoom.value = await FireStoreMethods().getManyRoomWithStatus(
        FirebaseAuth.instance.currentUser!.uid,
        page.value += 10,
        'PENDING',
      );
      isLoadMore.value = false;
    } else {
      isLoading.value = true;
      listRoom.value.clear();
      listRoom.value = await FireStoreMethods().getManyRoomWithStatus(
        FirebaseAuth.instance.currentUser!.uid,
        page.value,
        'PENDING',
      );
      isLoading.value = false;
    }
  }
}
