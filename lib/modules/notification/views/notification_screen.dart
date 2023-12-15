import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_rent/core/values/app_colors.dart';
import 'package:smart_rent/modules/notification/views/notification_item_widget.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
      // body: const SingleChildScrollView(
      //   child: Padding(
      //     padding: EdgeInsets.all(24),
      //     child: Center(
      //       child: Column(
      //         mainAxisAlignment: MainAxisAlignment.start,
      //         mainAxisSize: MainAxisSize.max,
      //         children: [
      //           NotificationItemWidget(
      //             content: 'Có phòng trọ mới vừa được đăng trên Rent House',
      //             time: '12:17 18/06/2023',
      //             typeNotification: 'new_room',
      //           ),
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
      body: ListView.builder(
        itemCount: 100,
        itemBuilder: (context, index) => Dismissible(
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
          child: index % 2 == 0
              ? const NotificationItemWidget(
                  content: 'Có phòng trọ mới vừa được đăng trên Rent House',
                  time: '12:17 18/06/2023',
                  typeNotification: 'like',
                )
              : const NotificationItemWidget(
                  content: 'Phòng trọ của bạn có một lượt yêu thích mới',
                  time: '12:17 18/06/2023',
                  typeNotification: 'new_room',
                ),
          onDismissed: (direction) {
            if (direction == DismissDirection.startToEnd) {
              Get.snackbar('delete', 'message');
            } else if (direction == DismissDirection.endToStart) {
              Get.snackbar('undo', 'message');
            }
          },
        ),
      ),
    );
  }
}
