import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HelpRegex {
  static bool isEmail(String email) {
    return RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
  }

  static bool isPhoneNumber(String phoneNumber) {
    return RegExp(r"^[0-9]{10,11}$").hasMatch(phoneNumber);
  }

  static bool isPassword(String password) {
    return RegExp(r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$")
        .hasMatch(password);
  }

  static bool isUsername(String username) {
    return RegExp(r"^[a-zA-Z0-9]{6,}$").hasMatch(username);
  }

  static bool isName(String name) {
    return RegExp(r"^[a-zA-Z ]{2,}$").hasMatch(name);
  }

  static bool isNumber(String number) {
    return RegExp(r"^[0-9]+$").hasMatch(number);
  }

  static bool isDistance(String number) {
    return RegExp(r"^[0-9]+(\.[0-9]+)?$").hasMatch(number);
  }

  // Kiểm tra tiếng Việt không dấu
  static bool isVietnameseNoDiacritics(String text) {
    return RegExp(r"^[a-zA-Z0-9 ]+$").hasMatch(text);
  }

  static formatCurrency(TextEditingController textEditingController) {
    final formatter = NumberFormat.currency(locale: 'vi_VN', symbol: '');

    if (textEditingController.text.isNotEmpty) {
      final doubleAmount = double.tryParse(
        textEditingController.text.replaceAll(RegExp(r'[^\d]'), ''),
      );

      if (doubleAmount != null) {
        final formattedValue = formatter.format(doubleAmount);
        textEditingController.value = TextEditingValue(
          text: formattedValue,
          selection: TextSelection.collapsed(offset: formattedValue.length - 1),
        );
      }
    }
  }
}
