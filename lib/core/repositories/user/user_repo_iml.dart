import 'package:dio/dio.dart';
import 'package:smart_rent/core/app/app_manager.dart';
import 'package:smart_rent/core/model/response/request_model.dart';
import 'package:smart_rent/core/model/user/user_bank_info_model.dart';
import 'package:smart_rent/core/model/user/user_model.dart';
import 'package:smart_rent/core/model/user/user_update_bank_info_model.dart';
import 'package:smart_rent/core/model/user/user_update_info_model.dart';
import 'package:smart_rent/core/repositories/dio/dio_provider.dart';
import 'package:smart_rent/core/repositories/log/log.dart';
import 'package:smart_rent/core/repositories/log/log_impl.dart';
import 'package:smart_rent/core/repositories/user/user_repo.dart';

class UserRepoIml implements UserRepo {
  Log log;
  final DioProvider dio;

  UserRepoIml()
      : log = LogImpl(),
        dio = DioProvider();
  @override
  Future<ResponseModel<List<UserModel>>> getAllUsers() async {
    const String url = '/users';
    Response response;
    try {
      response = await dio.get(url,
        headers: {
            'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AppManager().accessToken}',
        },
      );

      return ResponseModel<List<UserModel>>(
          errCode: response.data['errCode'],
          message: response.data['message'],
          data: _handleResponse<List<UserModel>>(response.data['data']));
    } catch (e) {
      log.e('getAllUsers', e.toString());
      return ResponseModel.failed(e);
    }
  }

  @override
  Future<ResponseModel<UserModel>> getCurrentUser(
      {required String accessToken}) async {
    const String url = '/users/current-user';
    
    try {
      final response = await dio.get(
        url,
        headers: {
            'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AppManager().accessToken}',
        },
      );

      print(response);

      return ResponseModel<UserModel>(
          errCode: response.data['errCode'],
          message: response.data['message'],
          data: _handleResponse<UserModel>(response.data['data']));
    } catch (e) {
      log.e('getCurrentUser', e.toString());
      return ResponseModel.failed(e);
    }
  }

  @override
  Future<ResponseModel<int>> updateInfo(
      {required UserUpdateInfoModel userUpdateInfoModel}) async {
    const String url = '/users';
    final FormData formData = await userUpdateInfoModel.toFormData();
    try {
      final response = await dio.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AppManager().accessToken}',
        },
        data: formData,
      );

      return ResponseModel<int>(
          errCode: response.data['errCode'],
          message: response.data['message'],
          data: response.data['data'] as int);
    } catch (e) {
      log.e('updateInfo', e.toString());
      return ResponseModel.failed(e);
    }
  }

  @override
  Future<ResponseModel<UserModel>> getUserById({required int id}) async {
    final String url = '/users/$id';
    try {
      final response = await dio.get(
        url,
        headers: {
            'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AppManager().accessToken}',
        },
      );

      return ResponseModel<UserModel>(
          errCode: response.data['errCode'],
          message: response.data['message'],
          data: _handleResponse<UserModel>(response.data['data']));
    } catch (e) {
      log.e('getUserById', e.toString());
      return ResponseModel.failed(e);
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

  @override
  Future<ResponseModel?> updateDeviceToken({
    required String deviceToken,
  }) async {
    const String url = '/users/device-token';

    try {
      await dio.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AppManager().accessToken}',
        },
        data: {
          'device_token': deviceToken,
        },
      );

      return null;
    } catch (e) {
      log.e('updateDeviceToken', e.toString());
      return ResponseModel(
        errCode: 500,
        message: 'Failed to update device token',
      );
    }
  }

  @override
  Future<ResponseModel<int>> updateBankInfo(
      {required UserUpdateBankInfoModel userUpdateBankInfoModel}) async {
    const String url = '/users/bank-info';

    try {
      final response = await dio.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AppManager().accessToken}',
        },
        data: userUpdateBankInfoModel.toMap(),
      );

      return ResponseModel<int>(
        errCode: response.data['errCode'],
        message: response.data['message'],
        data: response.data['data'] as int,
      );
    } catch (e) {
      log.e('updateBankInfo', e.toString());
      return ResponseModel(
        errCode: 500,
        message: 'Failed to update device token',
      );
    }
  }

  @override
  Future<ResponseModel<UserBankInfoModel>> getBankInfo() async {
    const String url = '/users/bank-info';

    try {
      final response = await dio.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AppManager().accessToken}',
        },
      );

      return ResponseModel<UserBankInfoModel>(
        errCode: response.data['errCode'],
        message: response.data['message'],
        data: UserBankInfoModel.fromMap(response.data['data']),
      );
    } catch (e) {
      log.e('updateBankInfo', e.toString());
      return ResponseModel(
        errCode: 500,
        message: 'Failed to update device token',
      );
    }
  }
}
