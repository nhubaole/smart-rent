// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$InvoiceImpl _$$InvoiceImplFromJson(Map<String, dynamic> json) =>
    _$InvoiceImpl(
      orderCode: json['orderCode'] as int,
      recieverId: json['recieverId'] as String,
      recieverName: json['recieverName'] as String,
      recieverPhoneNumber: json['recieverPhoneNumber'] as String,
      recieverNumberBank: json['recieverNumberBank'] as String,
      recieverBank: json['recieverBank'] as String,
      roomId: json['roomId'] as String,
      addressRoom: json['addressRoom'] as String,
      amountRoom: json['amountRoom'] as int,
      description: json['description'] as String,
      buyerId: json['buyerId'] as String,
      buyerName: json['buyerName'] as String,
      buyerEmail: json['buyerEmail'] as String,
      buyerPhone: json['buyerPhone'] as String,
      buyerAddress: json['buyerAddress'] as String,
      items: (json['items'] as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList(),
      cancelUrl: json['cancelUrl'] as String? ?? 'https://your-cancel-url.com',
      returnUrl: json['returnUrl'] as String? ?? 'https://your-success-url.com',
      expireAt: json['expireAt'] as int? ?? 1699814762,
      signalture: json['signalture'] as String? ?? 'hashcode',
      paymentLinkId: json['paymentLinkId'] as String? ?? 'paymentLink',
    );

Map<String, dynamic> _$$InvoiceImplToJson(_$InvoiceImpl instance) =>
    <String, dynamic>{
      'orderCode': instance.orderCode,
      'recieverId': instance.recieverId,
      'recieverName': instance.recieverName,
      'recieverPhoneNumber': instance.recieverPhoneNumber,
      'recieverNumberBank': instance.recieverNumberBank,
      'recieverBank': instance.recieverBank,
      'roomId': instance.roomId,
      'addressRoom': instance.addressRoom,
      'amountRoom': instance.amountRoom,
      'description': instance.description,
      'buyerId': instance.buyerId,
      'buyerName': instance.buyerName,
      'buyerEmail': instance.buyerEmail,
      'buyerPhone': instance.buyerPhone,
      'buyerAddress': instance.buyerAddress,
      'items': instance.items,
      'cancelUrl': instance.cancelUrl,
      'returnUrl': instance.returnUrl,
      'expireAt': instance.expireAt,
      'signalture': instance.signalture,
      'paymentLinkId': instance.paymentLinkId,
    };
