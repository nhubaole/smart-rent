import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_rent/core/resources/auth_methods.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

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
  void phoneAuthentication(String phoneNo) {
    AuthMethods.instance.phoneAuthentication(phoneNo);
  }
}
