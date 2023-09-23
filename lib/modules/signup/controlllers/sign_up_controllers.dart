import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_rent/core/resources/auth_methods.dart';

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
    await checkExistPhoneNumber(phoneNumber);
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

  Future<bool> checkExistPhoneNumber(String phoneNumber) async {
    await FirebaseFirestore.instance
        .collection('accounts')
        .where('phoneNumber', isEqualTo: phoneNumber)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        return true;
      }
    });
    return false;
  }
}
