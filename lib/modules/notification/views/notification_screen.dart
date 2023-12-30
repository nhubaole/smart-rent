import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_rent/core/model/invoice/invoice.dart';
import 'package:smart_rent/core/resources/firestore_methods.dart';
import 'package:smart_rent/core/values/app_colors.dart';
import 'package:smart_rent/modules/notification/controllers/notification_controller.dart';
import 'package:smart_rent/modules/notification/views/notification_item_widget.dart';
import 'package:smart_rent/modules/payment/views/payment_info_screen.dart';
import 'package:smart_rent/modules/payment/views/review_room.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notificationController = Get.put(NotificationController());
    notificationController.getListNoti(false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary98,
        title: const Text(
          'Thông báo',
          style: TextStyle(
            color: primary40,
            fontWeight: FontWeight.w700,
            fontSize: 22,
          ),
        ),
      ),
      body: Obx(
        () => notificationController.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(
                  color: primary95,
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
                            color: secondary20,
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
                                        await FireStoreMethods()
                                            .markAsReadNotification(
                                          notificationController
                                              .listNotifications
                                              .value[index]['id'],
                                        );
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
                                  FireStoreMethods().markAsReadNotification(
                                      notificationController.listNotifications
                                          .value[index]['id']);
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
                                      color: primary95,
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
                                          side: MaterialStateProperty.all(
                                            const BorderSide(
                                              color: primary40,
                                            ),
                                          ),
                                          shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                        child: const Text(
                                          'Xem thêm',
                                          style: TextStyle(
                                            color: primary40,
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
