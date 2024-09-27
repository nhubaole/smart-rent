import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '/core/model/account/Account.dart';
import '/core/model/room/room.dart';

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
        } else {
          // truong hop tao moi yeu cau
        }
      }
    }
  }
}
