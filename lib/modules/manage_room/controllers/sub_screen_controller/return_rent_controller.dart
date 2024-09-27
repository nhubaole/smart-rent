import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '/core/model/account/Account.dart';
import '/core/model/room/room.dart';
import '/core/resources/auth_methods.dart';

class ReturnRentController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  var isLoading = false.obs;
  var isLoadMore = false.obs;
  var listTicket = Rx<List<Map<String, dynamic>>>([]);
  var listRoom = Rx<List<Room>>([]);
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

      isLoadMore.value = false;
    } else {
      isLoading.value = true;
      listTicket.value.clear();
      listRoom.value.clear();

      isLoading.value = false;
    }
  }
}
