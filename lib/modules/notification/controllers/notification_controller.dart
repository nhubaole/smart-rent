import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:smart_rent/core/resources/firestore_methods.dart';

class NotificationController extends GetxController {
  var listNotifications = Rx<List<Map<String, dynamic>>>([]);
  var isLoading = Rx<bool>(false);
  var isLoadMore = Rx<bool>(false);
  var page = Rx<int>(10);

  Future getListNoti(bool isPagination) async {
    if (isPagination) {
      isLoadMore.value = true;
      listNotifications.value = await FireStoreMethods().getListNotification(
          FirebaseAuth.instance.currentUser!.uid, page.value += 10);
      isLoadMore.value = false;
    } else {
      isLoading.value = true;
      listNotifications.value = await FireStoreMethods().getListNotification(
          FirebaseAuth.instance.currentUser!.uid, page.value);
      isLoading.value = false;
    }
  }
}
