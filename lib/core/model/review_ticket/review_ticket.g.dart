// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_ticket.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReviewTicketImpl _$$ReviewTicketImplFromJson(Map<String, dynamic> json) =>
    _$ReviewTicketImpl(
      id: json['id'] as String,
      roomId: json['roomId'] as String,
      userId: json['userId'] as String,
      invoiceId: json['invoiceId'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      rating: (json['rating'] as num).toDouble(),
      createdAt: json['createdAt'] as String,
      image:
          (json['image'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
    );

Map<String, dynamic> _$$ReviewTicketImplToJson(_$ReviewTicketImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'roomId': instance.roomId,
      'userId': instance.userId,
      'invoiceId': instance.invoiceId,
      'title': instance.title,
      'content': instance.content,
      'rating': instance.rating,
      'createdAt': instance.createdAt,
      'image': instance.image,
    };
