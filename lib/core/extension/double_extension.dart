import 'package:intl/intl.dart';

final moneyVNFormat = NumberFormat.currency(locale: "vi_VN", symbol: "");

extension DoubleExt on double {
  String get toStringTotalPrice {
    return moneyVNFormat.format(this);
  }

  String get toFormattedPrice {
    if (this <= 0) {
      return "Miễn phí";
    } else if (this < 1000) {
      return "$this₫";
    } else if (this >= 1000 && this < 1000000) {
      return "${this / 1000}k";
    } else {
      return "${this / 1000000}tr";
    }
  }

  dynamic get getAcreage {
    return this % 1 == 0 ? toInt() : this;
  }
}
