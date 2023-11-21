import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'invoice.freezed.dart';
part 'invoice.g.dart';

@freezed
class Invoice with _$Invoice {
  const Invoice._();
  const factory Invoice({
    required int orderCode,
    required String recieverId,
    required String recieverName,
    required String recieverPhoneNumber,
    required String recieverNumberBank,
    required String recieverBank,
    required String addressRoom,
    required int amountRoom,
    required String description,
    required String buyerId,
    required String buyerName,
    required String buyerEmail,
    required String buyerPhone,
    required String buyerAddress,
    required List<Map<String, dynamic>> items,
    @Default('https://your-cancel-url.com') String cancelUrl,
    @Default('https://your-success-url.com') String returnUrl,
    @Default(1699814762) int expireAt,
    @Default('hashcode') String signalture,
    @Default('paymentLink') String paymentLinkId,
  }) = _Invoice;

  factory Invoice.fromJson(Map<String, dynamic> json) =>
      _$InvoiceFromJson(json);
}
