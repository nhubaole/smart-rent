import 'package:get/get.dart';
import 'package:intl/intl.dart';

extension StringExt on String {
  String get toStringRoomType {
    switch (this) {
      case 'single':
        return 'single_room';
      default:
        return 'getNameRoomType';
    }
  }

  String trParams([Map<String, String> params = const {}]) {
    var trans = tr;
    if (params.isNotEmpty) {
      params.forEach((key, value) {
        trans = trans.replaceAll('@$key', value);
      });
    }
    return trans;
  }

  String convertToISO8601(String date) {
    final parts = date.split('/');
    return '${parts[2]}-${parts[1]}-${parts[0]}';
  }

  DateTime? get toDateTime => DateFormat('dd/MM/yyyy').tryParse(this);
  
}
