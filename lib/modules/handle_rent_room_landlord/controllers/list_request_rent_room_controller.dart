import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:smart_rent/core/model/account/Account.dart';
import 'package:smart_rent/core/model/room/room.dart';
import 'package:smart_rent/core/resources/auth_methods.dart';
import 'package:smart_rent/core/resources/firestore_methods.dart';

class ListRequestRentRoomController extends GetxController {
  final Room room;
  ListRequestRentRoomController({required this.room});

  var isLoading = false.obs;
  var isLoadMore = false.obs;
  var listTicket = Rx<List<Map<String, dynamic>>>([]);
  var profileOwner = Rx<Account?>(null);
  var page = Rx<int>(10);

  @override
  void onInit() {
    getProfile(FirebaseAuth.instance.currentUser!.uid);

    super.onInit();
  }

  Future<void> getProfile(String uid) async {
    isLoading.value = true;
    profileOwner.value = await AuthMethods.getUserDetails(uid);
    isLoading.value = false;
  }

  Future<void> getListTicket(bool isPagination) async {
    if (isPagination) {
      isLoadMore.value = true;
      listTicket.value = await FireStoreMethods().getTicketsHandleRequestRent(
        FirebaseAuth.instance.currentUser!.uid,
        page.value += 10,
        'PENDING',
      );
      isLoadMore.value = false;
    } else {
      isLoading.value = true;
      listTicket.value.clear();
      listTicket.value = await FireStoreMethods().getTicketsHandleRequestRent(
        FirebaseAuth.instance.currentUser!.uid,
        page.value,
        'PENDING',
      );
      isLoading.value = false;
    }
  }
}
