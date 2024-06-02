import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_rent/core/resources/auth_methods.dart';
import 'package:smart_rent/core/values/key_value.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:smart_rent/core/widget/dialog_custom.dart';
import 'package:smart_rent/modules/login/model/auth_response_model.dart';
import 'package:smart_rent/modules/login/views/login_verify_screen.dart';
import 'package:smart_rent/modules/signup/views/sign_up_screen.dart';
import 'package:http/http.dart' as http;

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

  Future<bool?> onLogin({required String phoneNumber}) async {
    try {
      String? accessToken = await getAcessToken(phoneNumber: phoneNumber);

      if (accessToken != null) {
        await saveAccessToken(accessToken: accessToken);
      }
      return true;
    } catch (e) {
      debugPrint('[LoginController][onLogin]: ${e.toString()}');
      return null;
    }
  }

  Future<String?> getAcessToken({required String phoneNumber}) async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var data = json.encode({"userName": "0908069947", "password": "123456"});
      var dio = Dio();
      var response = await dio.request(
        'https://${dotenv.get('localhost_wan_simulator')}:3001/api-gateway/v1/auth/',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        AuthResponseModel authResponseModel =
            AuthResponseModel.fromJson(json.encode(response.data));
        return authResponseModel.accessToken;
      } else {
        debugPrint('[LoginController][submit]: ${response.statusMessage}');
        return null;
      }
    } catch (e) {
      debugPrint('[LoginController][submit]: ${e.toString()}');
      return null;
    }
  }

  Future<void> saveAccessToken({required String accessToken}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('accessToken', accessToken);
    print(prefs.getString('accessToken'));
  }
}
