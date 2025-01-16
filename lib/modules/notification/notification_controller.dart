import 'dart:developer';

import 'package:get/get.dart';
import 'package:smart_rent/core/enums/loading_type.dart';
import 'package:smart_rent/core/enums/notification_type.dart';
import 'package:smart_rent/core/model/notification_model.dart';
import 'package:smart_rent/core/repositories/notification/notification_repo_impl.dart';
import 'package:smart_rent/core/routes/app_routes.dart';
import 'package:smart_rent/modules/contract_detail/contract_detail_controller.dart';
import 'package:smart_rent/modules/landlord_detail_return_request/landlord_detail_return_request_controller.dart';

class NotificationController extends GetxController {
  final listNotifications = Rx<List<NotificationModel>>([]);
  final page = Rx<int>(10);
  final isLoading = LoadingType.INIT.obs;

  @override
  void onInit() {
    getListNoti();
    super.onInit();
  }

  Future getListNoti() async {
    isLoading.value = LoadingType.LOADING;
    final rq = await NotificationRepoImpl().getAllNotifications();
    if (rq.isSuccess()) {
      listNotifications.value = rq.data!;
      isLoading.value = LoadingType.LOADED;
    } else {
      isLoading.value = LoadingType.ERROR;
    }
  }

  onTapNoti(NotificationModel noti) {
    markAsRead(noti);
    switch (noti.type) {
      case NotificationType.CONTRACT:
        final contractID = noti.referenceId!;
        // TODO: Test
        Get.toNamed(
          AppRoutes.contractDetail,
          arguments: NotiArgument(contractID: 21),
        );
        break;
      case NotificationType.RENTAL_REQUEST:
        log('RENTAL_REQUEST: $noti');
        Get.toNamed(AppRoutes.requestRentV2);
        break;
      case NotificationType.RETURN_REQUEST:
        final returnRequestID = noti.referenceId!;
        Get.toNamed(
          AppRoutes.landlordDetailReturnRequest,
          arguments: NavNotiReturnRequest(returnRequestID: returnRequestID),
        );
        break;
      case NotificationType.NULL:
      case null:
        break;
      case NotificationType.PAYMENT:
        Get.toNamed(AppRoutes.paymentDetail, arguments: noti);
        break;
      case NotificationType.BILL:

      // TODO: Handle this case.
    }
  }

  markAsRead(NotificationModel noti) {
    int index = listNotifications.value.indexWhere((n) => n.id == noti.id);
    noti = noti.copyWith(isRead: true);
    listNotifications.value[index] = noti;
    update();
  }

  onReadAll() {
    listNotifications.value = listNotifications.value.map((noti) {
      return noti.copyWith(isRead: true);
    }).toList();
    update();
  }

}
