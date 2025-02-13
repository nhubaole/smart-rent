import 'package:smart_rent/core/app/app_manager.dart';
import 'package:smart_rent/core/di/getit_config.dart';
import 'package:smart_rent/core/model/rental_request/all_process_tracking_model.dart';
import 'package:smart_rent/core/model/rental_request/process_tracking_by_id_model.dart';
import 'package:smart_rent/core/model/rental_request/rental_request_all_model.dart';
import 'package:smart_rent/core/model/rental_request/rental_request_by_id_model.dart';
import 'package:smart_rent/core/model/rental_request/rental_request_create_model.dart';
import 'package:smart_rent/core/model/rental_request/rental_request_create_response_model.dart';
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
  Future<ResponseModel<dynamic>> createRentalRequest(
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

      return ResponseModel<RentalRequestCreateResponseModel>(
        errCode: response.data['errCode'],
        message: response.data['message'],
        data: response.data['data'] == null
            ? null
            : RentalRequestCreateResponseModel.fromMap(response.data['data']),
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

  @override
  Future<ResponseModel<List<AllProcessTrackingModel>>>
      getAllProcessTracking() async {
    const String url = '/requests/process-tracking';
    try {
      final response = await dio.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AppManager().accessToken}',
        },
      );

      return ResponseModel<List<AllProcessTrackingModel>>(
        errCode: response.data['errCode'],
        message: response.data['message'],
        data: List<AllProcessTrackingModel>.from(
          (response.data['data'] as List)
              .map((e) => AllProcessTrackingModel.fromMap(e))
              .toList(),
        ),
      );
    } catch (e) {
      log.e('getAllProcessTracking', e.toString());
      return ResponseModel.failed(e);
    }
  }

  @override
  Future<ResponseModel<List<ProcessTrackingByIdModel>>>
      getDetailProcessTrackingByID({required int id}) async {
    final String url = '/requests/$id/tracking-process';
    try {
      final response = await dio.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AppManager().accessToken}',
        },
      );

      return ResponseModel<List<ProcessTrackingByIdModel>>(
        errCode: response.data['errCode'],
        message: response.data['message'],
        data: List<ProcessTrackingByIdModel>.from(
          (response.data['data'] as List)
              .map((e) => ProcessTrackingByIdModel.fromMap(e))
              .toList(),
        ),
      );
    } catch (e) {
      log.e('getDetailProcessTrackingByID', e.toString());
      return ResponseModel.failed(e);
    }
  }
}
