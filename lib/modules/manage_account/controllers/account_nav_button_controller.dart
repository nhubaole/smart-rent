import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AccountNavButtonController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signOut() async {
    await _auth.signOut();
    GetStorage().erase();
  }

  void goToScreen(Widget sreen) {
    Get.to(sreen);
  }
}
