import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:smart_rent/core/resources/auth_methods.dart';
import 'package:smart_rent/core/values/KEY_VALUE.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  final box = GetStorage();

  //TextField Controllers to get data from TextFields
  final phoneNo = TextEditingController();

  /// This func will be used to register user with [EMAIL] & [Password]
  void registerUser(String email, String password) {
    String? error = AuthMethods.instance
        .createUserWithEmailAndPassword(email, password) as String?;
    if (error != null) {
      Get.showSnackbar(GetSnackBar(message: error.toString()));
    }
  }

  //Get phoneNo from user (Screen) and pass it to Auth Repository for Firebase Authentication
  void phoneAuthentication(String phoneNo) async {
    AuthMethods.instance.phoneAuthentication(phoneNo);
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
