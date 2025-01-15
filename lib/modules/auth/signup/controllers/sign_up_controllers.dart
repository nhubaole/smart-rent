import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:smart_rent/core/di/getit_config.dart';
import 'package:smart_rent/core/model/values/listProvinceVietNam.dart';
import 'package:smart_rent/core/repositories/auth/auth_repo_impl.dart';
import 'package:smart_rent/core/repositories/log/log.dart';

class SignUpController extends GetxController {
  final isShowPassword = false.obs;
  final now = DateTime.now();
  final GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();
  final fullName = TextEditingController();
  final phoneNumber = TextEditingController();
  final password = TextEditingController();
  final dateOfBirth = TextEditingController();
  final address = TextEditingController();
  final obscureText = Rx<bool>(true);

  late Log log;

  final dateOfBirthCheck = Rx<DateTime?>(null);
  final isVerifying = Rx<bool>(false);

  @override
  void onInit() {
    log = getIt<Log>();
    dateOfBirth.text =
        DateFormat('dd/MM/yyyy').format(DateTime.now()).toString();
    address.text = provinces[0];

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
    FocusManager.instance.primaryFocus?.unfocus();
    if (!signUpFormKey.currentState!.validate()) {
      return 'Vui lòng kiểm tra lại thông tin';
    }
    signUpFormKey.currentState!.save();
    final result = await AuthRepoImpl().register(
      phoneNumber: phoneNumber.text.trim(),
      fullName: fullName.text.trim(),
      address: address.text.trim(),
      password: password.text.trim(),
    );

    if (!result.isSuccess()) {
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
    int age = currentDate.year - selectedDate.year;
    if (currentDate.month < selectedDate.month ||
        (currentDate.month == selectedDate.month &&
            currentDate.day < selectedDate.day)) {
      age--;
    }
    return age >= 18;
  }
}
