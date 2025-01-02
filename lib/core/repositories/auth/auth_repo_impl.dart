import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:smart_rent/core/config/app_constant.dart';
import 'package:smart_rent/core/di/getit_config.dart';
import 'package:smart_rent/core/repositories/dio/dio_provider.dart';
import '/core/repositories/auth/auth_repo.dart';
import '/core/repositories/log/log.dart';

import '../../model/response/request_model.dart';

class AuthRepoImpl implements AuthRepo {
  final Log log;
  final DioProvider dio;

  AuthRepoImpl()
      : log = getIt<Log>(),
        dio = DioProvider();

  @override
  Future<ResponseModel> login({
    required String phoneNumber,
    required String password,
  }) async {
    const String url = AppConstant.authenLogin;
    final dataMapper = {
      "phone_number": phoneNumber,
      "password": password,
    };

    try {
      final response = await dio.post(url, data: dataMapper);
      return ResponseModel.fromJson(json.encode(response.data));
    } catch (e) {
      return ResponseModel.failed(e);
    }
  }

  @override
  Future<ResponseModel> register({
    required String phoneNumber,
    required String fullName,
    required String address,
    required String password,
  }) async {
    const String url = AppConstant.authenRegister;
    Response response;
    final dataMapper = {
      "phone_number": phoneNumber,
      "full_name": fullName,
      "address": address,
      "password": password
    };

    try {
      response = await dio.post(url, data: dataMapper);
      return ResponseModel.fromJson(json.encode(response.data));
    } catch (e) {
      return ResponseModel.failed(e);
    }
  }

  @override
  Future<ResponseModel> verifyOtp({
    required String phoneNumber,
    required String otp,
  }) async {
    const String url = AppConstant.authenVerifyOtp;
    Response response;
    final dataMapper = {
      "phone_number": phoneNumber,
      "otp": otp,
    };

    try {
      response = await dio.post(url, data: dataMapper);
    
      return ResponseModel.fromJson(json.encode(response.data));
    } catch (e) {
      return ResponseModel.failed(e);
    }
  }
}
