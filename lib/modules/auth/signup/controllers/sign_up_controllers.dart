import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:smart_rent/core/di/getit_config.dart';
import 'package:smart_rent/core/repositories/auth/auth_repo_impl.dart';
import 'package:smart_rent/core/repositories/log/log.dart';

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

    if (result.errCode == null || result.errCode! >= 400) {
      return 'Xảy ra lỗi';
    } else {
      return result.message;
    }
  }

  bool isDate(String str) {
    try {
      DateTime.tryParse(str);
      return true;
    } catch (e) {
      return false;
    }
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
