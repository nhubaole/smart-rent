import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_rent/core/app/app_manager.dart';
import 'package:smart_rent/core/enums/loading_type.dart';
import 'package:smart_rent/core/model/chat/message_model.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:smart_rent/core/repositories/chat/chat_repo_impl.dart';
import 'package:smart_rent/modules/chat/socket_service.dart';
import 'package:uuid/uuid.dart';

class ChatController extends GetxController {
  final RxList<types.Message> messages = <types.Message>[].obs;
  final isLoadingData = LoadingType.INIT.obs;
  late types.User currentUser = types.User(id: "1");
  final ChatRepoImpl chatRepo = ChatRepoImpl();
  final SocketService _socketService = Get.find();

  late final int conversationId;
  late final String companionName;
  late final String companionAvatarUrl;
  late final int companionId;

  @override
  void onInit() {
    super.onInit();
    currentUser = types.User(id: AppManager().currentUser?.id.toString() ?? "");

    conversationId = Get.arguments['conversationId'] ?? 0;
    companionName = Get.arguments['companionName'] ?? '';
    companionAvatarUrl = Get.arguments['companionAvatarUrl'] ?? '';
    companionId = Get.arguments['companionId'] ?? 0;

    fetchMessages();

    _socketService.messageStream.listen((data) {
      final message = convertToMessage(data);
      messages.insert(0, message);
    });
  }

  void fetchMessages() async {
    isLoadingData.value = LoadingType.LOADING;
    try {
      final response = await chatRepo.getMessagesByConversation(
        conversationID: conversationId,
      );

      if (response.isSuccess() && response.data != null) {
        messages.value = convertToChatMessages(response.data!);
        isLoadingData.value = LoadingType.LOADED;
      } else {
        isLoadingData.value = LoadingType.ERROR;
      }
    } catch (e) {
      isLoadingData.value = LoadingType.ERROR;
      print('Error fetching messages: $e');
    }
  }

  types.Message convertToMessage(Map<String, dynamic> data) {
    int senderId = data['sender_id'];
    return types.TextMessage(
      author: types.User(
          id: senderId.toString(),
          imageUrl:
              senderId.toString() != currentUser.id ? companionAvatarUrl : ""),
      createdAt: DateTime.parse(data['created_at']).millisecondsSinceEpoch,
      id: data['id'].toString(),
      text: data['content'],
    );
  }

  List<types.Message> convertToChatMessages(List<MessageModel> apiMessages) {
    return apiMessages.map((apiMessage) {
      if (apiMessage.type == 1) {
        return types.TextMessage(
          id: apiMessage.id.toString(),
          author: types.User(
              id: apiMessage.senderId.toString(),
              imageUrl: apiMessage.senderId.toString() != currentUser.id
                  ? companionAvatarUrl
                  : ""),
          text: apiMessage.content ?? '',
          createdAt: apiMessage.createdAt.millisecondsSinceEpoch,
        );
      } else if (apiMessage.type == 2) {
        final rentInfo = apiMessage.rentAutoContent;
        return types.CustomMessage(
          id: apiMessage.id.toString(),
          author: types.User(
              id: apiMessage.senderId.toString(),
              imageUrl: apiMessage.senderId.toString() != currentUser.id
                  ? companionAvatarUrl
                  : ""),
          metadata: rentInfo,
          createdAt: apiMessage.createdAt.millisecondsSinceEpoch,
        );
      }

      return types.TextMessage(
        text: "",
        id: apiMessage.id.toString(),
        author: types.User(
            id: apiMessage.senderId.toString(),
            imageUrl: apiMessage.senderId.toString() != currentUser.id
                ? companionAvatarUrl
                : ""),
        createdAt: apiMessage.createdAt.millisecondsSinceEpoch,
      );
    }).toList();
  }

  void handleAttachmentPressed() {
    // Logic xử lý khi nhấn vào đính kèm
  }

  void handleMessageTap(BuildContext context, types.Message message) {
    // Logic xử lý khi nhấn vào tin nhắn
  }

  void handlePreviewDataFetched(
    types.TextMessage message,
    types.PreviewData previewData,
  ) {
    final index = messages.indexWhere((element) => element.id == message.id);
    if (index != -1) {
      messages[index] = (messages[index] as types.TextMessage).copyWith(
        previewData: previewData,
      );
    }
  }

  void handleSendPressed(types.PartialText message) {
    _socketService.sendMessage({
      'sender_id': currentUser.id,
      'receiver_id': companionId,
      'conversation_id': conversationId,
      'content': message.text,
      'type': 1,
      'rent_auto_content': {},
    });
  }
}
