import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:smart_rent/core/model/room/room_model.dart';
import '/core/model/account/Account.dart';

class SendRequestRentRoomController extends GetxController {
  final RoomModel room;
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
  final currencyFormat = NumberFormat.currency(locale: 'vi_VN', symbol: '');

  // NumberFormat numberFormat =
  //     NumberFormat.currency(locale: 'vi_VN', symbol: '');

  @override
  void onInit() {
    priceSuggestTextController.addListener(formatCurrency);
    priceSuggestTextController.text =
        result != null ? result!['price'].toString() : '';
    quantityPeopleTextController.text =
        result != null ? result!['quantityPeople'].toString() : '';
    dateJoinTextController.text = result != null ? result!['dateJoin'] : '';
    dateLeaveTextController.text = result != null ? result!['dateLeave'] : '';
    specialRequestTextController.text =
        result != null ? result!['specialRequest'] : '';

    currencyFormat.format(room.totalPrice);
    super.onInit();
  }

  @override
  void onClose() {
    priceSuggestTextController.removeListener(formatCurrency);
    priceSuggestTextController.dispose();
    quantityPeopleTextController.dispose();
    dateJoinTextController.dispose();
    dateLeaveTextController.dispose();
    specialRequestTextController.dispose();
    super.onClose();
  }

  void formatCurrency() {
    final formatter = NumberFormat.currency(locale: 'vi_VN', symbol: '');

    if (priceSuggestTextController.text.isNotEmpty) {
      final doubleAmount = double.tryParse(
        priceSuggestTextController.text.replaceAll(RegExp(r'[^\d]'), ''),
      );

      if (doubleAmount != null) {
        final formattedValue = formatter.format(doubleAmount);
        priceSuggestTextController.value = TextEditingValue(
          text: formattedValue,
          selection: TextSelection.collapsed(offset: formattedValue.length - 1),
        );
      }
    }
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

  Future<void> sendRequest(RoomModel room) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      DateTime now = DateTime.now().add(const Duration(hours: 1)).toUtc();
      final timeStamp = now.millisecondsSinceEpoch ~/ 1000;
      Map<String, dynamic> data;

      if (result != null) {
        data = result!;
      }

      data = {
        'id': result != null ? result!['id'] : 1,
        'price': int.parse(
            priceSuggestTextController.value.text.replaceAll('.', '')),
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
      data['uidTenant'] = FirebaseAuth.instance.currentUser!.uid;
      data['status'] = 'PENDING';
    }
  }
}
