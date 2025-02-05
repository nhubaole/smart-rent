import 'package:get/get.dart';
import 'package:smart_rent/core/app/app_manager.dart';
import 'package:smart_rent/core/enums/loading_type.dart';
import 'package:smart_rent/core/model/chat/chat_conversation_model.dart';
import 'package:smart_rent/core/model/user/user_model.dart';
import 'package:smart_rent/core/repositories/chat/chat_repo_impl.dart';
import 'package:smart_rent/core/routes/app_routes.dart';
import 'package:smart_rent/modules/chat/socket_service.dart';

class ConversationController extends GetxController {
  final isLoadingData = LoadingType.INIT.obs;
  final conversations = <ChatConversationModel>[].obs;
  final SocketService _socketService = Get.find();


  @override
  void onInit() {
    fetchConversations();

     _socketService.messageStream.listen((data) {
      fetchConversations();
    });

    super.onInit();
  }

  fetchConversations() async {
    isLoadingData.value = LoadingType.LOADING;

    final response = await ChatRepoImpl().getConversationsByUser(userID: AppManager().currentUser?.id ?? 0);
    if (response.isSuccess() && response.data != null) {
      conversations.value = response.data!;
      isLoadingData.value = LoadingType.LOADED;
    } else {
      isLoadingData.value = LoadingType.ERROR;
    }
  }

  onNavToChat(ChatConversationModel conversation) {
    UserModel? otherUser =
        conversation.userAModel?.id == AppManager.instance.currentUser?.id
            ? conversation.userBModel
            : conversation.userAModel;

    Get.toNamed(AppRoutes.chat, arguments: {
      'conversationId': conversation.id,
      'companionName': otherUser?.fullName ?? '',
      'companionAvatarUrl': otherUser?.avatarUrl ?? '',
      'companionId': otherUser?.id ?? 0,
    });
  }

  // deleteConversation(int conversationID) async {
  //   try {
  //     // Assume the repo has a delete method
  //     await ChatRepoImpl().deleteConversation(conversationID: conversationID);
  //     conversations.removeWhere((conversation) => conversation.id == conversationID);
  //   } catch (e) {
  //     Get.snackbar('Error', 'Failed to delete conversation.');
  //   }
  // }
}
