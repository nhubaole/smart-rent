import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/config/app_colors.dart';
import '/core/values/app_colors.dart';

class NotificationController extends GetxController {
  var listNotifications = Rx<List<Map<String, dynamic>>>([]);
  var isLoading = Rx<bool>(false);
  var isLoadMore = Rx<bool>(false);
  var page = Rx<int>(10);

  Future getListNoti(bool isPagination) async {
    if (isPagination) {
      isLoadMore.value = true;

      isLoadMore.value = false;
    } else {
      isLoading.value = true;

      isLoading.value = false;
    }
  }

  Future<void> showDialogLoading(
    String message,
    String roomId,
    String notificationId,
    bool isRequestRented,
    bool isRequestReturnRent,
    bool isHandleRentRoom,
    bool isHandleRequestReturnRoom,
    bool isRenting,
  ) async {
    Get.dialog(
      PopScope(
        canPop: false,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                const CircularProgressIndicator(
                  color: AppColors.primary60,
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  message,
                  style: const TextStyle(color: AppColors.primary60),
                ),
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }
}
