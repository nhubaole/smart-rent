import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_rent/core/model/room/room.dart';
import 'package:smart_rent/core/resources/firestore_methods.dart';
import 'package:smart_rent/core/values/app_colors.dart';
import 'package:smart_rent/modules/detail/views/detail_screen.dart';

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

  Future<void> showDialogLoading(
    String message,
    String roomId,
    String notificationId,
  ) async {
    Get.dialog(
      PopScope(
        //canPop: false,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                const CircularProgressIndicator(
                  color: primary60,
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  message,
                  style: const TextStyle(color: primary60),
                ),
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );
    await FireStoreMethods().markAsReadNotification(notificationId);
    Room room = await FireStoreMethods().getRoomById(roomId);
    Get.back();
    Get.to(
      DetailScreen(
        room: room,
        isRented: false,
        isReturnRent: false,
        isHandleRequestReturnRoom: true,
        notificationId: notificationId,
      ),
    );
  }
}
