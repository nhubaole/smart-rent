import 'package:smart_rent/core/app/app_manager.dart';
import 'package:smart_rent/core/di/getit_config.dart';
import 'package:smart_rent/core/model/response/request_model.dart';
import 'package:smart_rent/core/model/return_request/return_request_by_id_model.dart';
import 'package:smart_rent/core/repositories/dio/dio_provider.dart';
import 'package:smart_rent/core/repositories/log/log.dart';
import 'package:smart_rent/core/repositories/return_request/return_request_repo.dart';

class ReturnRequestRepoImpl extends ReturnRequestRepo {
  final Log log;
  final DioProvider dio;
  ReturnRequestRepoImpl()
      : log = getIt<Log>(),
        dio = DioProvider();
  @override
  Future<ResponseModel<ReturnRequestByIdModel>> getReturnRequestById(
    int id,
  ) async {
    final String url = '/return-requests/$id';

    try {
      final response = await dio.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AppManager().accessToken}',
        },
      );

      return ResponseModel<ReturnRequestByIdModel>(
        errCode: response.data['errCode'],
        message: response.data['message'],
        data: ReturnRequestByIdModel.fromMap(response.data['data']),
      );
    } catch (e) {
      log.e('getReturnRequestById', e.toString());
      return ResponseModel.failed(e);
    }
  }

  @override
  Future<ResponseModel<bool>> confirmReturnRequest(int requestId) async {
    final String url = '/return-requests/confirm/$requestId';

    try {
      final response = await dio.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AppManager().accessToken}',
        },
      );

      return ResponseModel<bool>(
        errCode: response.data['errCode'],
        message: response.data['message'],
        data: response.data['data'] as bool,
      );
    } catch (e) {
      log.e('confirmReturnRequest', e.toString());
      return ResponseModel.failed(e);
    }
  }
}
