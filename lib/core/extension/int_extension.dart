import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:smart_rent/core/enums/gender.dart';

final moneyVNFormat = NumberFormat.currency(locale: "vi_VN", symbol: "");

extension IntExt on int {
  getNameGender() {
    switch (this) {
      case 0:
        return Gender.MALE;
      case 1:
        return Gender.FEMALE;
      default:
        return Gender.ALL;
    }
  }

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

  String toStringTotalthis({String? symbol}) {
    return '${moneyVNFormat.format(this)} ${symbol ?? 'VND/ ${'room'.tr}'}';
  }

  String get toFormattedPrice {
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

  int get getAcreage {
    return this * 10;
  }

  DateTime get toDateTime {
    return DateTime.fromMillisecondsSinceEpoch(this);
  }

  String get toFormatCurrency {
    return moneyVNFormat.format(this);
  }
}
