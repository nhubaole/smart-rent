import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:smart_rent/blank.dart';
import 'package:smart_rent/core/model/account/Account.dart';
import 'package:smart_rent/core/model/room/room.dart';
import 'package:smart_rent/core/resources/auth_methods.dart';
import 'package:smart_rent/core/resources/firebase_fcm.dart';
import 'package:smart_rent/core/resources/firestore_methods.dart';
import 'package:smart_rent/core/values/KEY_VALUE.dart';
import 'package:smart_rent/modules/root_view/views/root_screen.dart';

class SendRequestRentRoomController extends GetxController {
  final Room room;
  Map<String, dynamic>? result;
  SendRequestRentRoomController({
    required this.room,
    this.result,
  });

  final formKey = GlobalKey<FormState>();
  var priceSuggestTextController = TextEditingController();
  var quantityPeopleTextController = TextEditingController();
  var dateJoinTextController = TextEditingController();
  var dateLeaveTextController = TextEditingController();
  var specialRequestTextController = TextEditingController();
  var isJoinNow = Rx<bool>(false);
  var isLeave = Rx<bool>(false);
  var account = Rx<Account?>(null);

  @override
  void onInit() {
    priceSuggestTextController.text =
        result != null ? result!['price'].toString() : '';
    quantityPeopleTextController.text =
        result != null ? result!['quantityPeople'].toString() : '';
    dateJoinTextController.text = result != null ? result!['dateJoin'] : '';
    dateLeaveTextController.text = result != null ? result!['dateLeave'] : '';
    specialRequestTextController.text =
        result != null ? result!['specialRequest'] : '';
    super.onInit();
  }

  bool isDate(String str) {
    try {
      if (str.isEmpty || str == 'longTime') return false;
      DateTime.tryParse(str);

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> sendRequest(Room room) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      DateTime now = DateTime.now().add(const Duration(hours: 1)).toUtc();
      final timeStamp = now.millisecondsSinceEpoch ~/ 1000;
      String senderId = FirebaseAuth.instance.currentUser!.uid;
      Map<String, dynamic> data;
      String id = await FireStoreMethods().getDocumentId(
          KeyValue.KEY_TICKET_REQUEST_REQUEST_RENT_ROOM_COLLECTION);
      if (result != null) {
        data = result!;
      }

      data = {
        'id': result != null ? result!['id'] : id,
        'price': int.parse(priceSuggestTextController.value.text),
        'quantityPeople': int.parse(quantityPeopleTextController.value.text),
        'timeStamp': timeStamp,
      };

      if (isJoinNow.value) {
        // data['dateJoin'] =
        //     DateFormat('dd/MM/yyyy').format(DateTime.now()).toString();
        data['dateJoin'] = 'joinNow';
      } else {
        data['dateJoin'] = dateJoinTextController.value.text;
      }

      if (isLeave.value) {
        data['dateLeave'] = 'longTime';
      } else {
        data['dateLeave'] = dateLeaveTextController.value.text;
      }

      data['specialRequest'] = specialRequestTextController.value.text;
      data['roomId'] = room.id;
      data['uidLandlord'] = room.createdByUid;
      data['uidTenant'] = FirebaseAuth.instance.currentUser!.uid;
      data['status'] = 'PENDING';

      String rs = await FireStoreMethods()
          .sendTicketRequestRent(result != null ? result!['id'] : id, data);
      if (rs == 'success') {
        FireStoreMethods().updateStatusRoom(room.id, 'REQUESTRENT');
        account.value = await AuthMethods.getUserDetails(
            FirebaseAuth.instance.currentUser!.uid);
        FirebaseFCM().sendNotificationHTTP(
          senderId,
          room.createdByUid,
          await FireStoreMethods().getTokenDevice(room.createdByUid),
          'Bạn vừa nhận 1 yêu cầu thuê phòng',
          'Yêu cầu thuê phòng từ ${account.value!.username}',
          true,
          'https://images.unsplash.com/photo-1614107151234-06e5677c0126?q=80&w=2670&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
          'REQUEST_RENT_ROOM',
          {
            'roomId': room.id,
          },
        );
        AwesomeNotifications().createNotification(
          content: NotificationContent(
            id: 10,
            channelKey: 'basic_channel',
            title: 'Gửi yêu cầu thuê phòng thành công',
            body:
                'Bạn đã gửi yêu cầu thuê phòng, hãy kiên nhẫn đợi chủ nhà chấp nhận\nyêu cầu của bạn.',
          ),
        );

        Get.offAll(const Blank(
          screen: RootScreen(),
          message: 'Đang xử lý dữ liệu...',
        ));
      } else {
        Get.snackbar(
          'Thông báo',
          'Xảy ra lỗi vui lòng thử lại sau',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    }
  }
}
