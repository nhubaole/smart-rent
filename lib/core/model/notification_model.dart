// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:smart_rent/core/enums/notification_type.dart';

class NotificationModel {
  final int id;
  int? userId;
  int? referenceId;
  NotificationType? type;
  String? title;
  bool? isRead;
  DateTime? createdAt;
  DateTime? updatedAt;

  NotificationModel({
    required this.id,
    this.userId,
    this.referenceId,
    this.type,
    this.title,
    this.isRead,
    this.createdAt,
    this.updatedAt,
  });

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      id: map['id'],
      userId: map['user_id'],
      referenceId: map['reference_id'],
      type: NotificationTypeExtension.fromString(map['reference_type']),
      title: map['title'],
      isRead: map['is_read'],
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
    );
  }

  NotificationModel copyWith({
    int? id,
    int? userId,
    int? referenceId,
    NotificationType? type,
    String? title,
    bool? isRead,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      referenceId: referenceId ?? this.referenceId,
      type: type ?? this.type,
      title: title ?? this.title,
      isRead: isRead ?? this.isRead,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
