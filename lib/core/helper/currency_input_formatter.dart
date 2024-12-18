import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CurrencyInputFormatter extends TextInputFormatter {
  final NumberFormat _formatter = NumberFormat.currency(
    locale: 'vi_VN',
    symbol: '', // Use your preferred currency symbol
    decimalDigits: 2,
  );

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Prevent unnecessary processing
    if (newValue.text == oldValue.text) return newValue;

    // Remove non-numeric characters
    final numericString = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    // Return empty if input is cleared
    if (numericString.isEmpty) {
      return TextEditingValue(
        text: '',
        selection: TextSelection.collapsed(offset: 0),
      );
    }

    // Parse and format the numeric value
    double? number = double.tryParse(numericString);
    if (number == null) return newValue;

    final newText = _formatter.format(number / 100);

    // Calculate the new cursor position
    final newSelectionIndex =
        newText.length - (oldValue.text.length - oldValue.selection.end);

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(
        offset: newSelectionIndex.clamp(0, newText.length),
      ),
    );
  }
}
