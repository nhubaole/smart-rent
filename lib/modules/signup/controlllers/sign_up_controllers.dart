import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:smart_rent/core/model/account/Account.dart';
import 'package:smart_rent/core/resources/auth_methods.dart';
import 'package:smart_rent/core/values/app_colors.dart';
import 'package:smart_rent/core/values/key_value.dart';
import 'package:smart_rent/core/widget/dialog_custom.dart';
import 'package:smart_rent/modules/signup/views/dialog_otp.dart';
import 'package:smart_rent/modules/login/views/login_screen.dart';

class SignUpController extends GetxController {
  final signUpFormKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final phoneNumber = TextEditingController();
  final dateOfBirth = TextEditingController();
  final address = TextEditingController();

  late Account account;

  var dateOfBirthCheck = Rx<DateTime?>(null);
  var isVerifying = Rx<bool>(false);
  @override
  void onInit() {
    dateOfBirth.text =
        DateFormat('dd/MM/yyyy').format(DateTime.now()).toString();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void submit(Account account) async {
    try {
      isVerifying.value = true;
      String resQuery = await checkExistPhoneNumber(account.phoneNumber);

      if (resQuery != 'success') {
        Get.dialog(
          DialogCustom(
            onPressed: () {
              Get.to(() => const LoginScreen());
            },
            backgroundColor: Colors.white,
            iconPath: 'assets/images/ic_notify.png',
            title: 'Thông báo',
            subTitle:
                'Đã tồn tại tài khoản với số điện thoại này, đăng nhập ngay',
          ),
        );
      } else {
        // Tiến hành đăng kí tài khoản
        phoneAuthentication(account.phoneNumber, account);
      }
    } catch (e) {
      Get.snackbar('Lỗi', e.toString());
    }
    isVerifying.value = false;
  }

  void phoneAuthentication(String phoneNo, Account account) async {
    isVerifying.value = true;
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
    isVerifying.value = false;
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
