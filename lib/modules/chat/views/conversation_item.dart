import 'package:flutter/material.dart';
import 'package:smart_rent/core/app/app_manager.dart';
import 'package:smart_rent/core/model/chat/chat_conversation_model.dart';
import 'package:smart_rent/core/model/chat/chat_message_model.dart';
import 'package:smart_rent/core/model/user/user_model.dart';

class ConversationItem extends StatelessWidget {
  const ConversationItem({
    super.key,
    required this.conversation,
    required this.onPressed,
    required this.onLongPress,
  });

  final ChatConversationModel conversation;

  final Function(BuildContext context) onPressed;
  final Function(BuildContext context, LongPressStartDetails longPressDetails)
      onLongPress;

  @override
  Widget build(BuildContext context) {
    UserModel? otherUser =
        conversation.userAModel?.id == AppManager.instance.currentUser?.id
            ? conversation.userBModel
            : conversation.userAModel;

    if (otherUser == null) return SizedBox();

    return GestureDetector(
      onTap: () => onPressed(context),
      onLongPressStart: (longPressDetails) =>
          onLongPress(context, longPressDetails),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(60),
              child: CustomAvatarWidget(userAvatar: otherUser.avatarUrl ?? "",),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      otherUser.fullName ?? "",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    defaultLastMessageBuilder(conversation.lastMessage, conversation.lastMessage?.senderID == AppManager.instance.currentUser?.id),
                  ],
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                defaultLastMessageTimeBuilder(conversation.lastMessage),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget defaultLastMessageBuilder(ChatMessageModel? message, bool isMine) {
    if (message == null) {
      return const SizedBox.shrink();
    }

    return Opacity(
      opacity: 1,
      child: Text(
        (isMine ? "Bạn: " : "") + message.content,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
      ),
    );
  }

  Widget defaultLastMessageTimeBuilder(ChatMessageModel? message) {
    if (message == null) {
      return const SizedBox.shrink();
    }

    final now = DateTime.now();
    final duration = now.difference(message.createdAt);

    String timeStr;
    if (duration.inMinutes < 1) {
      timeStr = 'Bây giờ';
    } else if (duration.inHours < 1) {
      timeStr = '${duration.inMinutes} phút trước';
    } else if (duration.inDays < 1) {
      timeStr = '${duration.inHours} giờ trước';
    } else {
      timeStr =
          '${message.createdAt.year}/${message.createdAt.month}/${message.createdAt.day}';
    }

    return Opacity(
      opacity: 0.64,
      child: Text(timeStr, maxLines: 1, overflow: TextOverflow.clip),
    );
  }
}

class CustomAvatarWidget extends StatelessWidget {
  final String userAvatar;

  const CustomAvatarWidget({super.key, required this.userAvatar});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(60),
        image: DecorationImage(
          image: NetworkImage(userAvatar),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
