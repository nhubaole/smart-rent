import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:smart_rent/core/app/app_manager.dart';
import 'package:smart_rent/core/repositories/log/log_impl.dart';


class ResponseModel<T> {
  int? errCode;
  String? message;
  T? data;

  ResponseModel({
    this.errCode,
    this.message,
    this.data,
  });

  ResponseModel.failed(dynamic error) {
    LogImpl().e('ResponseModel', error.toString());
    // if (error.toString().contains('401')) {
    //   AppManager().forceLogOut();
    // }
    if (error is DioException) {
      errCode = error.response?.data['errCode'] as int;
      message = error.response?.data['message'];
      data = error.response?.data['data'];
    } else if (error is String) {
      errCode = 1000;
      message = error;
    } else if (error is Map) {
      errCode = 1000;
      message = error['message'];
      data = error['data'];
    } else {
      errCode = 1000;
      message = error.toString();
    
    }
  }

  bool isSuccess() => (errCode != null && errCode! < 400);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ResponseModel &&
          runtimeType == other.runtimeType &&
          errCode == other.errCode &&
          message == other.message &&
          data == other.data);

  @override
  int get hashCode => errCode.hashCode ^ message.hashCode ^ data.hashCode;

  @override
  String toString() {
    return 'RequestModel{ errCode: $errCode, message: $message, data: $data,}';
  }

  ResponseModel copyWith({
    int? errCode,
    String? message,
    T? data,
  }) {
    return ResponseModel(
      errCode: errCode ?? this.errCode,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'errCode': this.errCode,
      'message': this.message,
      'data': this.data,
    };
  }

  String toJson() => json.encode(toMap());

  factory ResponseModel.fromJson(String source) =>
      ResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  factory ResponseModel.fromMap(Map<String, dynamic> map) {
    return ResponseModel(
      errCode: map['errCode'] as int,
      message: map['message'] as String,
      data: map['data'] as T,
    );
  }
}
