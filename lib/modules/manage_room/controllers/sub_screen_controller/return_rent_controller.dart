import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:smart_rent/core/model/account/Account.dart';
import 'package:smart_rent/core/model/room/room.dart';
import 'package:smart_rent/core/resources/auth_methods.dart';
import 'package:smart_rent/core/resources/firestore_methods.dart';

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
      listTicket.value = await FireStoreMethods().getTicketsRequestReturn(
        FirebaseAuth.instance.currentUser!.uid,
        page.value += 10,
        'PENDING',
      );

      for (var i = 0; i < listTicket.value.length; i++) {
        isLoadMore.value = true;
        final room = await FireStoreMethods()
            .getRoomById(listTicket.value[i]['roomId'].toString());
        listRoom.value.add(room);
      }

      isLoadMore.value = false;
    } else {
      isLoading.value = true;
      listTicket.value.clear();
      listRoom.value.clear();
      listTicket.value = await FireStoreMethods().getTicketsRequestReturn(
          FirebaseAuth.instance.currentUser!.uid, page.value, 'PENDING');
      for (var i = 0; i < listTicket.value.length; i++) {
        isLoading.value = true;
        final room = await FireStoreMethods()
            .getRoomById(listTicket.value[i]['roomId'].toString());
        listRoom.value.add(room);
      }

      isLoading.value = false;
    }
  }
}
