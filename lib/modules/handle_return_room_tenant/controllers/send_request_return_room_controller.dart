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

class SendRequestReturnRoomController extends GetxController {
  final Room room;
  Map<String, dynamic>? result;
  SendRequestReturnRoomController({
    required this.room,
    this.result,
  });
  var textFormReturnDate = TextEditingController();
  var textFormReason = TextEditingController();
  var isReturnNow = Rx<bool>(false);
  var isAgreePolicy = Rx<bool>(false);
  final formKey = GlobalKey<FormState>();
  var account = Rx<Account?>(null);

  @override
  void onInit() {
    textFormReason.text = result != null ? result!['reason'] : '';
    textFormReturnDate.text = result != null ? result!['returnDate'] : '';
    super.onInit();
  }

  bool isDate(String str) {
    try {
      if (str.isEmpty) return false;
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
      if (isAgreePolicy.value) {
        if (result != null) {
          // truong hop sua noi dung yeu cau
          result!['reason'] = textFormReason.text;
          result!['returnDate'] = textFormReturnDate.value.text;
          result!['timeStamp'] = timeStamp;
          if (isReturnNow.value) {
            result!['returnDate'] =
                DateFormat('dd/MM/yyyy').format(DateTime.now()).toString();
          }
          data = result!;
        } else {
          // truong hop tao moi yeu cau
          String id = await FireStoreMethods().getDocumentId(
              KeyValue.KEY_TICKET_REQUEST_RETURN_RENT_ROOM_COLLECTION);
          data = {
            'id': id,
            'roomId': room.id,
            'uidTenant': senderId,
            'uidLandlord': room.createdByUid,
            'returnDate': textFormReturnDate.value.text,
            'reason': textFormReason.text,
            'timeStamp': timeStamp,
            'status': 'PENDING',
          };
          if (isReturnNow.value) {
            data['returnDate'] =
                DateFormat('dd/MM/yyyy').format(DateTime.now()).toString();
          }
        }

        String rs = await FireStoreMethods().sendTicketRequestReturnRent(data);
        if (rs == 'success') {
          FireStoreMethods().updateStatusRoom(room.id, 'REQUESTRETURN');
          account.value = await AuthMethods.getUserDetails(senderId);
          FirebaseFCM().sendNotificationHTTP(
            senderId,
            room.createdByUid,
            await FireStoreMethods().getTokenDevice(room.createdByUid),
            'Bạn vừa nhận 1 yêu cầu trả phòng',
            'Yêu cầu trả phòng từ ${account.value!.username}',
            true,
            'https://images.unsplash.com/photo-1614107151234-06e5677c0126?q=80&w=2670&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
            'REQUEST_RETURN_ROOM',
            {
              'roomId': room.id,
            },
          );
          AwesomeNotifications().createNotification(
            content: NotificationContent(
              id: 10,
              channelKey: 'basic_channel',
              title: 'Gửi yêu cầu trả phòng thành công',
              body:
                  'Bạn đã gửi yêu cầu trả phòng, hãy kiên nhẫn đợi chủ nhà chấp nhận\nyêu cầu của bạn.',
            ),
          );
        }

        Get.offAll(const Blank(
          screen: RootScreen(),
          message: 'Đang xử lý dữ liệu...',
        ));

        // Get.back();
        // Get.back();
      } else {
        Get.snackbar(
          'Thông báo',
          'Bạn chưa đồng ý với chính sách của chúng tôi',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    }
  }
}
