import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_rent/core/resources/auth_methods.dart';
import 'package:smart_rent/core/values/KEY_VALUE.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  //TextField Controllers to get data from TextFields
  final name = TextEditingController();
  final phoneNumber = TextEditingController();
  final dateOfBirth = TextEditingController();
  final address = TextEditingController();

  /// This func will be used to register user with [EMAIL] & [Password]
  void registerUser(String email, String password) {
    String? error = AuthMethods.instance
        .createUserWithEmailAndPassword(email, password) as String?;
    if (error != null) {
      Get.showSnackbar(GetSnackBar(message: error.toString()));
    }
  }

  //Get phoneNo from user (Screen) and pass it to Auth Repository for Firebase Authentication
  void phoneAuthentication(String phoneNumber) async {
    //await checkExistPhoneNumber(phoneNumber);
    AuthMethods.instance.phoneAuthentication(phoneNumber);
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
