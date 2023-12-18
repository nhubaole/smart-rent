import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'review_ticket.freezed.dart';
part 'review_ticket.g.dart';

@freezed
class ReviewTicket with _$ReviewTicket {
  const ReviewTicket._();
  const factory ReviewTicket({
    required String id,
    required String roomId,
    required String userId,
    required String invoiceId,
    required String title,
    required String content,
    required double rating,
    required num createdAt,
    @Default([]) List<String> image,
  }) = _ReviewTicket;

  factory ReviewTicket.fromJson(Map<String, dynamic> json) =>
      _$ReviewTicketFromJson(json);
}
