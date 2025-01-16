import 'package:smart_rent/core/app/app_manager.dart';
import 'package:smart_rent/core/di/getit_config.dart';
import 'package:smart_rent/core/model/billing/bill_by_id_model.dart';
import 'package:smart_rent/core/model/billing/bill_by_month_and_user_model.dart';
import 'package:smart_rent/core/model/billing/bill_by_status_model.dart';
import 'package:smart_rent/core/model/billing/billing_all_metric_model.dart';
import 'package:smart_rent/core/model/billing/billing_create_index_request_model.dart';
import 'package:smart_rent/core/model/billing/billing_create_index_response.dart';
import 'package:smart_rent/core/model/billing/billing_list_index_by_landlord_model.dart';
import 'package:smart_rent/core/model/response/request_model.dart';
import 'package:smart_rent/core/repositories/billing/billing_repo.dart';
import 'package:smart_rent/core/repositories/dio/dio_provider.dart';
import 'package:smart_rent/core/repositories/log/log.dart';

class BillingRepoImpl extends BillingRepo {
  final Log log;
  final DioProvider dio;
  BillingRepoImpl()
      : log = getIt<Log>(),
        dio = DioProvider();
  @override
  Future<ResponseModel<List<BillByMonthAndUserModel>>> getBillByMonthAndUser({
    required int month,
    required int year,
  }) async {
    final String url = '/billings/get-by-month/$year/$month';
    try {
      final response = await dio.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AppManager().accessToken}',
        },
      );

      return ResponseModel<List<BillByMonthAndUserModel>>(
        errCode: response.data['errCode'],
        message: response.data['message'],
        data: response.data['data'] != null
            ? (response.data['data'] as List)
                .map((i) => BillByMonthAndUserModel.fromMap(i))
                .toList()
            : null,
      );
    } catch (e) {
      log.e('getBillByMonthAndUser', e.toString());
      return ResponseModel.failed(e);
    }
  }

  @override
  Future<ResponseModel<BillByIdModel>> getBillByID(
      {required int billID}) async {
    final String url = '/billings/$billID';
    try {
      final response = await dio.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AppManager().accessToken}',
        },
      );

      return ResponseModel<BillByIdModel>(
        errCode: response.data['errCode'],
        message: response.data['message'],
        data: response.data['data'] != null
            ? BillByIdModel.fromMap(response.data['data'])
            : null,
      );
    } catch (e) {
      log.e('getBillByID', e.toString());
      return ResponseModel.failed(e);
    }
  }

  @override
  Future<ResponseModel<BillingAllMetricModel>> getBillAllMetric({
    required int roomID,
    required int month,
    required int year,
  }) async {
    const String url = '/billings/get-metrics';
    try {
      final response = await dio.post(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${AppManager().accessToken}',
      }, data: {
        'room_id': roomID,
        'month': month,
        'year': year,
      });

      return ResponseModel<BillingAllMetricModel>(
        errCode: response.data['errCode'],
        message: response.data['message'],
        data: response.data['data'] != null
            ? BillingAllMetricModel.fromMap(response.data['data'])
            : null,
      );
    } catch (e) {
      log.e('getBillAllMetric', e.toString());
      return ResponseModel.failed(e);
    }
  }

  @override
  Future<ResponseModel<List<BillByStatusModel>>> getBillByStatus(
      {required int status}) async {
    final String url = '/billings/status/$status';
    try {
      final response = await dio.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AppManager().accessToken}',
        },
      );

      return ResponseModel<List<BillByStatusModel>>(
        errCode: response.data['errCode'],
        message: response.data['message'],
        data: response.data['data'] != null
            ? (response.data['data'] as List)
                .map((i) => BillByStatusModel.fromMap(i))
                .toList()
            : null,
      );
    } catch (e) {
      log.e('getBillByStatusModel', e.toString());
      return ResponseModel.failed(e);
    }
  }

  @override
  Future<ResponseModel<List<BillingListIndexByLandlordModel>>>
      getBillListIndexByLandlord({
    required int month,
    required int year,
    required bool isWater,
  }) async {
    final String url =
        '/billings/index/$year/$month/${isWater ? 'water' : 'electric'}';
    try {
      final response = await dio.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AppManager().accessToken}',
        },
      );

      return ResponseModel<List<BillingListIndexByLandlordModel>>(
        errCode: response.data['errCode'],
        message: response.data['message'],
        data: response.data['data'] != null
            ? List<BillingListIndexByLandlordModel>.from(
                (response.data['data'] as List)
                    .map((i) => BillingListIndexByLandlordModel.fromMap(i))
                    .toList())
            : [],
      );
    } catch (e) {
      log.e('getBillListIndexByLandlord', e.toString());
      return ResponseModel.failed(e);
    }
  }

  @override
  Future<ResponseModel<BillingCreateIndexResponse>> createIndex(
      {required BillingCreateIndexRequestModel request}) async {
    const String url = '/billings/index';
    try {
      final response = await dio.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AppManager().accessToken}',
        },
        data: request.toMap(),
      );

      return ResponseModel<BillingCreateIndexResponse>(
        errCode: response.data['errCode'],
        message: response.data['message'],
        data: BillingCreateIndexResponse.fromMap(response.data['data']),
      );
    } catch (e) {
      log.e('createIndex', e.toString());
      return ResponseModel.failed(e);
    }
  }
}
