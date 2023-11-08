import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_rent/core/model/account/Account.dart';
import 'package:smart_rent/core/resources/auth_methods.dart';
import 'package:smart_rent/core/values/app_colors.dart';
import 'package:smart_rent/core/values/key_value.dart';
import 'package:smart_rent/core/widget/dialog_otp.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  final name = TextEditingController();
  final phoneNumber = TextEditingController();
  final dateOfBirth = TextEditingController();
  final address = TextEditingController();

  void phoneAuthentication(String phoneNo, Account account) async {
    AuthMethods.sentOtp(
      phone: phoneNo,
      errorStep: () => Get.snackbar('Thông báo', 'Lỗi gửi OTP'),
      nextStep: () {
        Get.dialog(
          DialogOTP(
            onPressed: () {},
            backgroundColor: primary60,
            phoneNumber: account.phoneNumber,
            user: account,
          ),
        );
      },
    );
  }

  bool isDate(String str) {
    try {
      DateTime.tryParse(str);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<String> checkExistPhoneNumber(String phoneNumber) async {
    String res = 'Something went wrong';
    try {
      await FirebaseFirestore.instance
          .collection(KeyValue.KEY_COLLECTION_ACCOUNT)
          .where('phoneNumber', isEqualTo: phoneNumber)
          .get()
          .then(
        (value) {
          //is not empty -> co tai khoan
          if (value.docs.isEmpty) {
            res = 'success';
          } else {
            res = 'Số điện thoại đã được sử dụng';
          }
        },
      );
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  bool is18OrOlder(DateTime selectedDate) {
    final currentDate = DateTime.now();
    var age = currentDate.year - selectedDate.year;
    if (currentDate.month < selectedDate.month ||
        (currentDate.month == selectedDate.month &&
            currentDate.day < selectedDate.day)) {
      age--;
    }
    return age >= 18;
  }
}
