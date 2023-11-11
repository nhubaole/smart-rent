import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:smart_rent/core/model/account/Account.dart';
import 'package:smart_rent/core/model/room/room.dart';
import 'package:smart_rent/core/resources/auth_methods.dart';
import 'package:smart_rent/core/values/key_value.dart';

class RentedRoomController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  var isLoading = false.obs;
  RxList<Room> listRoom = <Room>[].obs;
  var profileOwner = Rx<Account?>(null);

  @override
  void onInit() {
    super.onInit();
    getListRoom();
    getProfile(FirebaseAuth.instance.currentUser!.uid);
  }

  Future<void> getProfile(String uid) async {
    isLoading.value = true;
    profileOwner.value = await AuthMethods.getUserDetails(uid);

    isLoading.value = false;
  }

  Future<void> getListRoom() async {
    isLoading.value = true;
    update();
    try {
      final querySnapshot = await firestore
          .collection(KeyValue.KEY_COLLECTION_ROOM)
          .where('createdByUid',
              isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .where('status', isEqualTo: 'RENTED')
          .get();
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
}
