import 'dart:convert';

class MessageModel {
  final int id;
  final int conversationId;
  final int senderId;
  final int type;
  final String? content;
  final Map<String, dynamic>? rentAutoContent;
  final DateTime createdAt;

  MessageModel({
    required this.id,
    required this.conversationId,
    required this.senderId,
    required this.type,
    this.content,
    this.rentAutoContent,
    required this.createdAt,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'] as int,
      conversationId: json['conversation_id'] as int,
      senderId: json['sender_id'] as int,
      type: json['type'] as int,
      content: json['content'] as String?, // Allow null values
      rentAutoContent: json['rent_auto_content'] != null
          ? jsonDecode(json['rent_auto_content']) as Map<String, dynamic>
          : null, // Handle null or empty rent_auto_content
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }
}