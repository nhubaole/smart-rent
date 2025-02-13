import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class NumberFormatter extends TextInputFormatter {
  final NumberFormat _formatter = NumberFormat("#,###");

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) return newValue;

    try {
      final newValueText = newValue.text.replaceAll(RegExp(r'[^\d]'), '');
      final number = int.parse(newValueText);

      final newFormattedValue = _formatter.format(number);

      return TextEditingValue(
        text: newFormattedValue,
        selection: TextSelection.collapsed(offset: newFormattedValue.length),
      );
    } catch (e) {
      return oldValue;
    }
  }
}
