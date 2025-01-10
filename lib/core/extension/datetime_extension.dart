import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DatetimeExt on DateTime {
  String get toPediod {
    return '$month/$year';
  }

  String get toDayMonthYear {
    return '$day/$month/$year';
  }

  static DateTime? getParsedDate(String time) {
    try {
      return DateFormat('dd/MM/yyyy').parseStrict(time);
    } catch (e) {
      return null;
    }
  }

  String get yyyymmddHHmmss => DateFormat('yyyy-MM-dd HH:mm:ss').format(this);
  String get ddMMyyyyHHmmss => DateFormat('dd-MM-yyyy HH:mm:ss').format(this);
  String get ddMMyyyyHHmm => DateFormat('dd-MM-yyyy HH:mm').format(this);
  String get hhmmDDMMyyyy => DateFormat('HH:mm dd-MM-yyyy').format(this);
  String get ddMMyyyy => DateFormat('dd/MM/yyyy').format(this);
  String get yyyyMMdd => DateFormat('yyyy-MM-dd').format(this);
  String get hhmm => DateFormat('HH:mm').format(this);
  String get yyyymmdd => DateFormat('yyyy-MM-dd').format(this);
  String get mmss => DateFormat('mm:ss').format(this);

  static DateTime parseFormatEEEddMMMyyyyHHmmss(String formatedString) =>
      DateFormat("EEE, dd MMM yyyy HH:mm:ss 'GMT'").parse(formatedString);
  static DateTime parseFormatddMMyyyyHHmm(String formatedString) =>
      DateFormat('dd-MM-yyyy HH:mm').parse(formatedString);
  static DateTime parseFormatddMMyyyy(String formatedString) =>
      DateFormat('dd-MM-yyyy').parse(formatedString);
  DateTime get nextDate => add(const Duration(days: 1));
  static DateTime parseFormatmmss(String formatedString) =>
      DateFormat('mm:ss').parse(formatedString);

  bool isSameDay(DateTime other) => DateUtils.isSameDay(this, other);
  bool get isToday => isSameDay(DateTime.now());
  bool get isTomorrow => isSameDay(DateTime.now().add(const Duration(days: 1)));
}
