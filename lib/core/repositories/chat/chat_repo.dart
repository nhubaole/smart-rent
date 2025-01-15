import 'package:smart_rent/core/model/chat/message_model.dart';
import 'package:smart_rent/core/model/response/request_model.dart';
import 'package:smart_rent/core/model/chat/chat_conversation_model.dart';

abstract class ChatRepo {
  Future<ResponseModel<List<ChatConversationModel>>> getConversationsByUser({
    required int userID,
  });
  Future<ResponseModel<List<MessageModel>>> getMessagesByConversation({
    required int conversationID,
  });
}
