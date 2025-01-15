import 'package:smart_rent/core/app/app_manager.dart';
import 'package:smart_rent/core/di/getit_config.dart';
import 'package:smart_rent/core/model/chat/message_model.dart';
import 'package:smart_rent/core/model/response/request_model.dart';
import 'package:smart_rent/core/model/chat/chat_conversation_model.dart';
import 'package:smart_rent/core/repositories/chat/chat_repo.dart';
import 'package:smart_rent/core/repositories/dio/dio_provider.dart';
import 'package:smart_rent/core/repositories/log/log.dart';
import 'package:smart_rent/core/repositories/user/user_repo_iml.dart';

class ChatRepoImpl extends ChatRepo {
  final Log log;
  final DioProvider dio;

  ChatRepoImpl()
      : log = getIt<Log>(),
        dio = DioProvider();

  @override
  Future<ResponseModel<List<ChatConversationModel>>> getConversationsByUser({
    required int userID,
  }) async {
    final String url = '/conversations/user/$userID';
    try {
      final response = await dio.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AppManager().accessToken}',
        },
      );

      if (response.data['errCode'] == 200) {
        final conversations = (response.data['data'] as List)
            .map((item) => ChatConversationModel.fromJson(item))
            .toList();

        // Fetch user details for each conversation
        for (var conversation in conversations) {
          final userAResponse =
              await UserRepoIml().getUserById(id: conversation.userA);
          final userBResponse =
              await UserRepoIml().getUserById(id: conversation.userB);

          if (userAResponse.isSuccess() && userAResponse.data != null) {
            conversation.userAModel = userAResponse.data!;
          }

          if (userBResponse.isSuccess() && userBResponse.data != null) {
            conversation.userBModel = userBResponse.data!;
          }
        }

        return ResponseModel<List<ChatConversationModel>>(
          errCode: response.data['errCode'],
          message: response.data['message'],
          data: conversations,
        );
      } else {
        return ResponseModel.failed(response.data['message']);
      }
    } catch (e) {
      log.e('getConversationsByUser', e.toString());
      return ResponseModel.failed(e);
    }
  }

  @override
  Future<ResponseModel<List<MessageModel>>> getMessagesByConversation({
    required int conversationID,
  }) async {
    final String url = '/messages/conversation/$conversationID';
    try {
      final response = await dio.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AppManager().accessToken}',
        },
      );

      if (response.data['errCode'] == 200) {
        final messages = (response.data['data'] as List)
            .map((item) => MessageModel.fromJson(item))
            .toList();

        return ResponseModel<List<MessageModel>>(
          errCode: response.data['errCode'],
          message: response.data['message'],
          data: messages,
        );
      } else {
        return ResponseModel.failed(response.data['message']);
      }
    } catch (e) {
      log.e('getMessagesByConversation', e.toString());
      return ResponseModel.failed(e);
    }
  }
}
