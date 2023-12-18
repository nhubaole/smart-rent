import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:smart_rent/core/model/account/Account.dart';
import 'package:smart_rent/core/model/room/room.dart';
import 'package:smart_rent/core/resources/auth_methods.dart';
import 'package:smart_rent/core/resources/firestore_methods.dart';

class RequestRentController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  var isLoading = false.obs;
  var isLoadMore = false.obs;
  var listRoom = Rx<List<Room>>([]);
  List<Map<String, dynamic>> listMap = [];
  var profileOwner = Rx<Account?>(null);
  var page = Rx<int>(10);

  @override
  void onInit() {
    getListRoom(false);
    getProfile(FirebaseAuth.instance.currentUser!.uid);
    super.onInit();
  }

  Future<void> getProfile(String uid) async {
    isLoading.value = true;
    profileOwner.value = await AuthMethods.getUserDetails(uid);
    isLoading.value = false;
  }

  Future<void> getListRoom(bool isPagination) async {
    if (isPagination) {
      isLoadMore.value = true;
      listMap = await FireStoreMethods().getTicketsRequestRent(
        FirebaseAuth.instance.currentUser!.uid,
        page.value += 10,
        'PENDING',
      );

      for (int i = 0; i < listMap.length; i++) {
        isLoadMore.value = true;
        listRoom.value.add(
          await FireStoreMethods().getRoomById(listMap[i]['roomId']),
        );
      }

      isLoadMore.value = false;
    } else {
      isLoading.value = true;
      listRoom.value.clear();
      listMap = await FireStoreMethods().getTicketsRequestRent(
        FirebaseAuth.instance.currentUser!.uid,
        page.value,
        'PENDING',
      );

      for (int i = 0; i < listMap.length; i++) {
        isLoading.value = true;
        listRoom.value.add(
          await FireStoreMethods().getRoomById(listMap[i]['roomId']),
        );
      }
      isLoading.value = false;
    }
  }
}
