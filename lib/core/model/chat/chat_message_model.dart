class ChatMessageModel {
  final int id;
  final int conversationID;
  final int senderID;
  final String? content;
  final String? rentAutoContent;
  final DateTime createdAt;

  ChatMessageModel({
    required this.id,
    required this.conversationID,
    required this.senderID,
    required this.content,
    this.rentAutoContent,
    required this.createdAt,
  });

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel(
      id: json['id'],
      conversationID: json['conversation_id'],
      senderID: json['sender_id'],
      content: json['content'],
      rentAutoContent: json['rent_auto_content'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}