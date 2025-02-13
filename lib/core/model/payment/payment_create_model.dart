// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';

class PaymentCreateModel {
  String? code;
  int? senderId;
  int? billId;
  int? contractId;
  int? returnRequestId;
  int? amount;
  int? status;
  String? tranferContent;
  String? evidenceImage;
  DateTime? paidTime;

  PaymentCreateModel({
    this.code,
    this.senderId,
    this.billId,
    this.contractId,
    this.returnRequestId,
    this.amount,
    this.status,
    this.tranferContent,
    this.evidenceImage,
    this.paidTime,
  });

  Future<FormData> toFormData() async {
    return FormData.fromMap({
      'code': code,
      'sender_id': senderId,
      'bill_id': billId,
      'contract_id': contractId,
      'return_request_id': returnRequestId,
      'amount': amount,
      'status': status,
      'transfer_content': tranferContent,
      'evidence_image': evidenceImage != null
          ? await MultipartFile.fromFile(evidenceImage!)
          : null,
      'paid_time': paidTime.toString(),
    });
  }

  @override
  String toString() {
    return 'PaymentCreateModel(code: $code, senderId: $senderId, billId: $billId, contractId: $contractId, returnRequestId: $returnRequestId, amount: $amount, status: $status, tranferContent: $tranferContent, evidenceImage: $evidenceImage, paidTime: $paidTime)';
  }
}
