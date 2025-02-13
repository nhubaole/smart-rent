import 'package:smart_rent/core/model/bank_model.dart';
import 'package:smart_rent/core/model/payment/payment_all_model.dart';
import 'package:smart_rent/core/model/payment/payment_create_model.dart';
import 'package:smart_rent/core/model/payment/payment_detail_info_model.dart';
import 'package:smart_rent/core/model/response/request_model.dart';

abstract class PaymentRepo {
  Future<ResponseModel<List<PaymentAllModel>>> getAllPayment();
  Future<ResponseModel<PaymentDetailInfoModel>> getPaymentDetailInfo({
    required int billID,
    required String type,
  });

  Future<ResponseModel<Map<String, dynamic>>> createPayment({
    required PaymentCreateModel paymentCreateModel,
  });

  Future<ResponseModel<List<BankModel>>> getAllBanks();
  Future<ResponseModel<PaymentAllModel>> getPaymentById({required int id});
  Future<ResponseModel<int>> confirmPayment({required int id});
}
