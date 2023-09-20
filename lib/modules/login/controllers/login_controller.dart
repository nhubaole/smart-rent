import 'package:flutter/material.dart';
import 'package:smart_rent/core/resources/auth_methods.dart';
import 'package:smart_rent/modules/login/views/login_verify_screen.dart';

Future<void> navigatorLoginVerify(
    BuildContext context, String phoneNumber) async {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (ctx) => LoginVerifyScreen(
        phoneNumber: phoneNumber,
      ),
    ),
  );
}

Future<String> fetchOTP(String phoneNumber) async {
  String res = 'Some erro occured';

  try {
    res = await AuthMethods().signUpUserWithPhoneNumber(phoneNumber);
  } catch (error) {
    res = error.toString();
  }

  return res;
}
