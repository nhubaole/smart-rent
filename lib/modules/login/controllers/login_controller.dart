import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_rent/core/resources/auth_methods.dart';
import 'package:smart_rent/core/values/key_value.dart';
import 'package:smart_rent/core/widget/dialog_custom.dart';
import 'package:smart_rent/modules/login/views/login_verify_screen.dart';
import 'package:smart_rent/modules/signup/views/sign_up_screen.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final phoneNo = TextEditingController();
  var isLoading = Rx<bool>(false);

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

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

  void submit() async {
    try {
      isLoading.value = true;
      String resQuery = await checkExistPhoneNumber(phoneNo.text.trim());
      if (resQuery == 'exist') {
        phoneAuthentication(phoneNo.text.trim());
        Get.to(
          () => LoginVerifyScreen(
            phoneNumber: phoneNo.text.trim(),
          ),
        );
      } else {
        Get.dialog(
          DialogCustom(
              onPressed: () {
                Get.to(() => const SignUpScreen());
              },
              backgroundColor: Colors.white,
              iconPath: 'assets/images/ic_notify.png',
              title: 'Thông báo',
              subTitle:
                  'Không tồn tại tài khoản với số điện thoại này, đăng kí ngay'),
        );
      }
      isLoading.value = false;
    } catch (error) {
      isLoading.value = false;
      Get.snackbar('Error', error.toString());
    }
    isLoading.value = false;
  }
}
