import 'package:smart_rent/core/model/chat/chat_message_model.dart';
import 'package:smart_rent/core/model/user/user_model.dart';

class ChatConversationModel {
  final int id;
  final int userA;
  final int userB;
  final ChatMessageModel? lastMessage;
  UserModel? userAModel;
  UserModel? userBModel;

  ChatConversationModel({
    required this.id,
    required this.userA,
    required this.userB,
    this.lastMessage,
    this.userAModel,
    this.userBModel,
  });

  factory ChatConversationModel.fromJson(Map<String, dynamic> json) {
    return ChatConversationModel(
      id: json['id'],
      userA: json['user_a'],
      userB: json['user_b'],
      lastMessage: json['last_message'] != null
          ? ChatMessageModel.fromJson(json['last_message'])
          : null,
    );
  }
}