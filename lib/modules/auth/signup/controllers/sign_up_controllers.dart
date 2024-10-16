import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../core/di/getit_config.dart';
import '../../login/views/login_screen.dart';
import '/core/model/account/Account.dart';
import '/core/repositories/auth/auth_repo_impl.dart';
import '/core/repositories/log/log.dart';
import '/core/resources/auth_methods.dart';
import '/core/values/key_value.dart';
import '/core/widget/dialog_custom.dart';

class SignUpController extends GetxController {
  var isShowPassword = false.obs;
  final now = DateTime.now();
  late final GlobalKey<FormState> signUpFormKey;
  final fullName = TextEditingController(text: DateTime.now().toString());
  final phoneNumber = TextEditingController(
      text: DateTime.now().microsecondsSinceEpoch.toString());
  final password = TextEditingController(text: DateTime.now().toString());
  final dateOfBirth = TextEditingController(text: DateTime.now().toString());
  final address = TextEditingController(text: DateTime.now().toString());

  late Log log;
  late Account account;

  var dateOfBirthCheck = Rx<DateTime?>(null);
  var isVerifying = Rx<bool>(false);

  @override
  void onInit() {
    log = getIt<Log>();
    dateOfBirth.text =
        DateFormat('dd/MM/yyyy').format(DateTime.now()).toString();
    signUpFormKey = GlobalKey<FormState>();
    super.onInit();
  }

  @override
  void onClose() {
    fullName.dispose();
    phoneNumber.dispose();
    password.dispose();
    dateOfBirth.dispose();
    address.dispose();
    super.onClose();
  }

  Future<String?> onRegister() async {
    final result = await AuthRepoImpl(log).register(
      phoneNumber: phoneNumber.text.trim(),
      fullName: fullName.text.trim(),
      address: address.text.trim(),
      password: password.text.trim(),
    );

    print(result);

    if (result.errCode == null || result.errCode! >= 400) {
      return 'Xảy ra lỗi';
    } else {
      return result.message;
    }
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
        // Get.dialog(
        //   DialogOTP(),
        // );
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
