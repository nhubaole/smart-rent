import 'package:smart_rent/core/app/app_manager.dart';
import 'package:smart_rent/core/di/getit_config.dart';
import 'package:smart_rent/core/model/rental_request/rental_request_all_model.dart';
import 'package:smart_rent/core/model/rental_request/rental_request_by_id_model.dart';
import 'package:smart_rent/core/model/rental_request/rental_request_create_model.dart';
import 'package:smart_rent/core/model/response/request_model.dart';
import 'package:smart_rent/core/repositories/dio/dio_provider.dart';
import 'package:smart_rent/core/repositories/log/log.dart';
import 'package:smart_rent/core/repositories/rental_request/rental_request_repo.dart';

class RentalRequestRepoImpl extends RentalRequestRepo {
  final Log log;
  final DioProvider dio;
  RentalRequestRepoImpl()
      : log = getIt<Log>(),
        dio = DioProvider();
  @override
  Future<ResponseModel<List<RentalRequestAllModel>>>
      getAllRentalRequest() async {
    const String url = '/requests';
    try {
      final response = await dio.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AppManager().accessToken}',
        },
      );

      return ResponseModel<List<RentalRequestAllModel>>(
        errCode: response.data['errCode'],
        message: response.data['message'],
        data: List<RentalRequestAllModel>.from(
          (response.data['data'] as List)
              .map((e) => RentalRequestAllModel.fromMap(e))
              .toList(),
        ),
      );
    } catch (e) {
      log.e('getAllRentalRequest', e.toString());
      return ResponseModel.failed(e);
    }
  }

  @override
  Future<ResponseModel<bool>> createRentalRequest(
      RentalRequestCreateModel request) async {
    const String url = '/requests';
    try {
      final response = await dio.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AppManager().accessToken}',
        },
        data: request.toMap(),
      );

      return ResponseModel<bool>(
        errCode: response.data['errCode'],
        message: response.data['message'],
        data: response.data['data'] as bool,
      );
    } catch (e) {
      log.e('createRentalRequest', e.toString());
      return ResponseModel.failed(e);
    }
  }
  
  @override
  Future<ResponseModel<int>> approveRentalRequest(int id) async {
    final String url = '/requests/$id/review?action=approve';
    try {
      final response = await dio.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AppManager().accessToken}',
        },
      );

      return ResponseModel<int>(
        errCode: response.data['errCode'],
        message: response.data['message'],
        data: response.data['data'] as int,
      );
    } catch (e) {
      log.e('createRentalRequest', e.toString());
      return ResponseModel.failed(e);
    }
  }

  @override
  Future<ResponseModel<int>> declineRentalRequest(int id) async {
    final String url = '/requests/$id/review?action=decline';
    try {
      final response = await dio.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AppManager().accessToken}',
        },
      );

      return ResponseModel<int>(
        errCode: response.data['errCode'],
        message: response.data['message'],
        data: response.data['data'] as int,
      );
    } catch (e) {
      log.e('createRentalRequest', e.toString());
      return ResponseModel.failed(e);
    }
  }

  @override
  Future<ResponseModel<RentalRequestByIdModel>> getRentalRequestById(
      int id) async {
    final String url = '/requests/$id';
    try {
      final response = await dio.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AppManager().accessToken}',
        },
      );

      return ResponseModel<RentalRequestByIdModel>(
        errCode: response.data['errCode'],
        message: response.data['message'],
        data: RentalRequestByIdModel.fromMap(response.data['data']),
      );
    } catch (e) {
      log.e('getRentalRequestById', e.toString());
      return ResponseModel.failed(e);
    }
  }
}
