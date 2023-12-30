import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_rent/core/resources/auth_methods.dart';
import 'package:smart_rent/core/values/key_value.dart';
import 'package:smart_rent/modules/login/views/login_verify_screen.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  final phoneNo = TextEditingController();

  void phoneAuthentication(String phoneNo) async {
    AuthMethods.sentOtp(
      phone: phoneNo,
      errorStep: () => Get.snackbar('Thông báo', 'Lỗi gửi OTP'),
      nextStep: () => Get.to(
        () => LoginVerifyScreen(phoneNumber: phoneNo),
      ),
    );
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
            res = 'not-exist';
          } else {
            res = 'exist';
          }
        },
      );
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
