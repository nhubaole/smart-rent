import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:smart_rent/core/app/app_manager.dart';
import 'package:smart_rent/core/model/response/request_model.dart';
import 'package:smart_rent/core/model/user_model.dart';
import 'package:smart_rent/core/repositories/log/log.dart';
import 'package:smart_rent/core/repositories/user/user_repo.dart';

class UserRepoIml implements UserRepo {
  Log log;
  final String domain;
  final Dio dio;

  UserRepoIml(this.log)
      : domain = dotenv.get('base_url_prod'),
        dio = Dio();
  @override
  Future<ResponseModel<List<UserModel>>> getAllUsers() async {
    final String url = '$domain/users';
    Response response;
    try {
      response = await dio.get(url,
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Authorization': AppManager().accressToken,
          }));

      return ResponseModel<List<UserModel>>(
          errCode: response.data['errCode'],
          message: response.data['message'],
          data: _handleResponse<List<UserModel>>(response.data['data']));
    } catch (e) {
      log.e('getAllUsers', e.toString());
      return ResponseModel();
    }
  }

  @override
  Future<ResponseModel<UserModel>> getCurrentUser(
      {required String accessToken}) async {
    final String url = '$domain/users/current-user';
    Response response;
    try {
      response = await dio.get(url,
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $accessToken',
          }));

      return ResponseModel<UserModel>(
          errCode: response.data['errCode'],
          message: response.data['message'],
          data: _handleResponse<UserModel>(response.data['data']));
    } catch (e) {
      log.e('getUserById', e.toString());
      return ResponseModel();
    }
  }

  @override
  Future<ResponseModel<UserModel>> updateUser() {
    // TODO: implement updateUser
    throw UnimplementedError();
  }

  @override
  Future<ResponseModel<UserModel>> getUserById({required int id}) async {
    final String url = '$domain/users/$id';
    Response response;
    try {
      response = await dio.get(url,
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Authorization': AppManager().accressToken,
          }));

      return ResponseModel<UserModel>(
          errCode: response.data['errCode'],
          message: response.data['message'],
          data: _handleResponse<UserModel>(response.data['data']));
    } catch (e) {
      log.e('getUserById', e.toString());
      return ResponseModel();
    }
  }

  T _handleResponse<T>(dynamic data) {
    if (T == UserModel) {
      return UserModel.fromMap(data) as T;
    } else if (T == List<UserModel>) {
      return List<UserModel>.from(
          (data as List).map((item) => UserModel.fromMap(item))) as T;
    }
    throw UnsupportedError('Type $T is not supported');
  }
}
