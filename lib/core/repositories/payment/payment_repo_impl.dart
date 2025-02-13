import 'package:smart_rent/core/app/app_manager.dart';
import 'package:smart_rent/core/di/getit_config.dart';
import 'package:smart_rent/core/model/bank_model.dart';
import 'package:smart_rent/core/model/payment/payment_all_model.dart';
import 'package:smart_rent/core/model/payment/payment_create_model.dart';
import 'package:smart_rent/core/model/payment/payment_detail_info_model.dart';
import 'package:smart_rent/core/model/response/request_model.dart';
import 'package:smart_rent/core/repositories/dio/dio_provider.dart';
import 'package:smart_rent/core/repositories/log/log.dart';
import 'package:smart_rent/core/repositories/payment/payment_repo.dart';

class PaymentRepoImpl extends PaymentRepo {
  final Log log;
  final DioProvider dio;
  PaymentRepoImpl()
      : log = getIt<Log>(),
        dio = DioProvider();
  @override
  Future<ResponseModel<List<PaymentAllModel>>> getAllPayment() async {
    const String url = '/payments';
    try {
      final response = await dio.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AppManager().accessToken}',
        },
      );

      return ResponseModel<List<PaymentAllModel>>(
        errCode: response.data['errCode'],
        message: response.data['message'],
        data: List<PaymentAllModel>.from(
          (response.data['data'] as List)
              .map((e) => PaymentAllModel.fromMap(e))
              .toList(),
        ),
      );
    } catch (e) {
      log.e('getAllPayment', e.toString());
      return ResponseModel.failed(e);
    }
  }

  @override
  Future<ResponseModel<PaymentDetailInfoModel>> getPaymentDetailInfo(
      {required int billID, required String type}) async {
    final String url = '/payments/detail-info?type=$type&id=$billID';
    try {
      final response = await dio.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AppManager().accessToken}',
        },
      );

      return ResponseModel<PaymentDetailInfoModel>(
        errCode: response.data['errCode'],
        message: response.data['message'],
        data: PaymentDetailInfoModel.fromMap(response.data['data']),
      );
    } catch (e) {
      log.e('getBillByStatusModel', e.toString());
      return ResponseModel.failed(e);
    }
  }

@override
  Future<ResponseModel<Map<String, dynamic>>> createPayment({
    required PaymentCreateModel paymentCreateModel,
  }) async {
    const String url = '/payments';
    try {
      final response = await dio.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AppManager().accessToken}',
        },
        data: await paymentCreateModel.toFormData(),
      );

      return ResponseModel<Map<String, dynamic>>(
        errCode: response.data['errCode'],
        message: response.data['message'],
        data: response.data,
      );
    } catch (e) {
      log.e('createPayment', e.toString());
      return ResponseModel.failed(e);
    }
  }

  @override
  Future<ResponseModel<List<BankModel>>> getAllBanks() async {
    const String url = '/payments/banks';
    try {
      final response = await dio.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AppManager().accessToken}',
        },
      );

      return ResponseModel<List<BankModel>>(
        errCode: response.data['errCode'],
        message: response.data['message'],
        data: (response.data['data'] as List)
            .map((e) => BankModel.fromMap(e))
            .toList(),
      );
    } catch (e) {
      log.e('getAllBanks', e.toString());
      return ResponseModel.failed(e);
    }
  }

  @override
  Future<ResponseModel<PaymentAllModel>> getPaymentById(
      {required int id}) async {
    final String url = '/payments/$id';
    try {
      final response = await dio.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AppManager().accessToken}',
        },
      );

      return ResponseModel<PaymentAllModel>(
        errCode: response.data['errCode'],
        message: response.data['message'],
        data: PaymentAllModel.fromMap(response.data['data']),
      );
    } catch (e) {
      log.e('getAllBanks', e.toString());
      return ResponseModel.failed(e);
    }
  }

  @override
  Future<ResponseModel<int>> confirmPayment({required int id}) async {
    final String url = '/payments/$id';
    try {
      final response = await dio.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AppManager().accessToken}',
        },
      );

      return ResponseModel<int>(
        errCode: response.data['errCode'],
        message: response.data['message'],
        data:
            response.data['data'] != null ? response.data['data'] as int : null,
      );
    } catch (e) {
      log.e('getAllBanks', e.toString());
      return ResponseModel.failed(e);
    }
  }
}
