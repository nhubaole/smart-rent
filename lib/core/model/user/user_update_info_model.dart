// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:dio/dio.dart';

class UserUpdateInfoModel {
  final int role;
  final int id;
  final String phoneNumber;
  final String fullName;

  UserUpdateInfoModel({
    required this.role,
    required this.id,
    required this.phoneNumber,
    required this.fullName,
  });

  UserUpdateInfoModel copyWith({
    int? role,
    int? id,
    String? phoneNumber,
    String? fullName,
  }) {
    return UserUpdateInfoModel(
      role: role ?? this.role,
      id: id ?? this.id,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      fullName: fullName ?? this.fullName,
    );
  }

  Future<FormData> toFormData() async {
    FormData formData = FormData();
    formData.fields
      ..add(MapEntry('role', role.toString()))
      ..add(MapEntry('id', id.toString()))
      ..add(MapEntry('phone_number', phoneNumber))
      ..add(MapEntry('full_name', fullName));
    return formData;
  }
}
