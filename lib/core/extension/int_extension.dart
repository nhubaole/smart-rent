import 'package:intl/intl.dart';

final moneyVNFormat = NumberFormat.currency(locale: "vi_VN", symbol: "");

extension IntExt on int {
  getNameGender() {}

  String get toStringRatingType {
    switch (this) {
      case < 2.5:
        return 'Tệ';
      case < 4:
        return 'Có tiềm năng';
      default:
        return 'Tốt';
    }
  }

  String toStringTotalthis(String? symbol) {
    return '${moneyVNFormat.format(this)} ${symbol ?? ''}';
  }

  String toFormattedPrice() {
    if (this <= 0) {
      return "Miễn phí";
    } else if (this < 1000) {
      return "$this ₫";
    } else if (this >= 1000 && this < 1000000) {
      return "${this / 1000} k";
    } else {
      return "${this / 1000000} tr";
    }
  }

  String get getStatusRoom {
    return this == 1 ? 'available' : 'unavailable';
  }
}
