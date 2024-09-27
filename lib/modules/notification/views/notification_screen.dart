import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../core/config/app_colors.dart';
import '/core/model/invoice/invoice.dart';
import '/core/values/app_colors.dart';
import '/modules/notification/controllers/notification_controller.dart';
import '/modules/notification/views/notification_item_widget.dart';
import '/modules/payment/views/payment_info_screen.dart';
import '/modules/payment/views/review_room.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notificationController = Get.put(NotificationController());
    notificationController.getListNoti(false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary98,
        title: const Text(
          'Thông báo',
          style: TextStyle(
            color: AppColors.primary40,
            fontWeight: FontWeight.w700,
            fontSize: 22,
          ),
        ),
      ),
      body: Obx(
        () => notificationController.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(
                  color: AppColors.primary95,
                  backgroundColor: Colors.white,
                ),
              )
            : notificationController.listNotifications.value.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Lottie.asset(
                          'assets/lottie/empty.json',
                          repeat: true,
                          reverse: true,
                          height: 300,
                          width: double.infinity,
                        ),
                        const Text(
                          'Bạn chưa có thông báo',
                          style: TextStyle(
                            color: AppColors.secondary20,
                            fontSize: 18,
                            fontWeight: FontWeight.w200,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  )
                : RefreshIndicator(
                    onRefresh: () {
                      return notificationController.getListNoti(false);
                    },
                    child: ListView.builder(
                      itemCount: notificationController
                              .listNotifications.value.length +
                          1,
                      itemBuilder: (context, index) {
                        if (index <
                            notificationController
                                .listNotifications.value.length) {
                          return Dismissible(
                            key: UniqueKey(),
                            background: Container(
                              alignment: Alignment.centerLeft,
                              color: Colors.red,
                              child: Container(
                                margin: const EdgeInsets.only(left: 50),
                                child: const Text(
                                  'Delete',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            secondaryBackground: Container(
                              color: Colors.green,
                              child: Container(
                                alignment: Alignment.centerRight,
                                margin: const EdgeInsets.only(right: 50),
                                child: const Text(
                                  'Undo',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            child: GestureDetector(
                              onTap: () async {
                                if (!notificationController
                                    .listNotifications.value[index]['isRead']) {
                                  switch (notificationController
                                      .listNotifications
                                      .value[index]['data']['content_type']) {
                                    case 'REQUEST_RETURN_ROOM':
                                      {
                                        notificationController
                                            .showDialogLoading(
                                          'Đang xử lý...',
                                          notificationController
                                              .listNotifications
                                              .value[index]['room']['roomId'],
                                          notificationController
                                              .listNotifications
                                              .value[index]['id'],
                                          false,
                                          false,
                                          false,
                                          true,
                                          false,
                                        );
                                        break;
                                      }
                                    case 'ACCEPT_REQUEST_RENT':
                                      {
                                        Map<String, dynamic> response =
                                            notificationController
                                                .listNotifications.value[index];
                                        Invoice invoice = Invoice.fromJson(
                                            response['room']['invoice']);
                                        Get.to(
                                          () => PaymentInforScreen(
                                              invoice: invoice,
                                              isReturn: false),
                                        );
                                        break;
                                      }
                                    case 'REQUEST_RENT_ROOM':
                                      {
                                        notificationController
                                            .showDialogLoading(
                                          'Đang xử lý...',
                                          notificationController
                                              .listNotifications
                                              .value[index]['room']['roomId'],
                                          notificationController
                                              .listNotifications
                                              .value[index]['id'],
                                          false,
                                          false,
                                          true,
                                          false,
                                          false,
                                        );
                                        break;
                                      }
                                    case 'DECLINE_REQUEST_RENT':
                                      {
                                        notificationController
                                            .getListNoti(true);
                                        break;
                                      }
                                    case 'APPROVEDPAYMENT':
                                      {
                                        Get.to(
                                          () => ReviewRoom(
                                            invoice: Invoice.fromJson(
                                                notificationController
                                                        .listNotifications
                                                        .value[index]['room']
                                                    ['invoice']),
                                          ),
                                        );

                                        break;
                                      }
                                  }
                                }
                                notificationController.getListNoti(true);
                              },
                              child: NotificationItemWidget(
                                data: notificationController
                                    .listNotifications.value[index],
                              ),
                            ),
                            onDismissed: (direction) {
                              if (direction == DismissDirection.startToEnd) {
                                Get.snackbar('delete', 'message');
                              } else if (direction ==
                                  DismissDirection.endToStart) {
                                Get.snackbar('undo', 'message');
                              }
                            },
                          );
                        } else {
                          return Obx(
                            () => notificationController.isLoadMore.value
                                ? const Center(
                                    child: CircularProgressIndicator(
                                      color: AppColors.primary95,
                                      backgroundColor: Colors.white,
                                    ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: OutlinedButton(
                                        onPressed: () {
                                          notificationController
                                              .getListNoti(true);
                                        },
                                        style: ButtonStyle(
                                          side: WidgetStateProperty.all(
                                            const BorderSide(
                                              color: AppColors.primary40,
                                            ),
                                          ),
                                          shape: WidgetStateProperty.all(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                        child: const Text(
                                          'Xem thêm',
                                          style: TextStyle(
                                            color: AppColors.primary40,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                          );
                        }
                      },
                    ),
                  ),
      ),
    );
  }
}
