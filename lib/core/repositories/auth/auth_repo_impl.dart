import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '/core/repositories/auth/auth_repo.dart';
import '/core/repositories/log/log.dart';

import '../../model/response/request_model.dart';

class AuthRepoImpl implements AuthRepo {
  Log log;
  final String domain;
  final Dio dio;

  AuthRepoImpl(this.log)
      : domain = dotenv.get('base_url_prod'),
        dio = Dio();

  @override
  Future<ResponseModel> login({
    required String phoneNumber,
    required String password,
  }) async {
    final String url = '$domain/authen/login';
    Response response;
    final dataMapper = {
      "phone_number": phoneNumber,
      "password": password,
    };

    try {
      response = await dio.post(url, data: dataMapper);
      return ResponseModel.fromJson(json.encode(response.data));
    } catch (e) {
      log.e('login', e.toString());
      return ResponseModel();
    }
  }

  @override
  Future<ResponseModel> register({
    required String phoneNumber,
    required String fullName,
    required String address,
    required String password,
  }) async {
    final String url = '$domain/authen/register';
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
      log.e('register', e.toString());
      return ResponseModel();
    }
  }

  @override
  Future<ResponseModel> verifyOtp({
    required String phoneNumber,
    required String otp,
  }) async {
    final String url = '$domain/authen/verify-otp';
    Response response;
    final dataMapper = {
      "phone_number": phoneNumber,
      "otp": otp,
    };

    try {
      response = await dio.post(url, data: dataMapper);
      return ResponseModel.fromJson(json.encode(response.data));
    } catch (e) {
      log.e('register', e.toString());
      return ResponseModel();
    }
  }
}
