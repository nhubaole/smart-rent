import 'dart:math';

import 'package:flutter/material.dart';
import 'package:smart_rent/core/values/app_colors.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

class ConversationItem extends StatelessWidget {
  const ConversationItem({
    Key? key,
    required this.conversation,
    required this.onPressed,
    required this.onLongPress,
  }) : super(key: key);

  final ZIMKitConversation conversation;

  // event
  final Function(BuildContext context) onPressed;
  final Function(BuildContext context, LongPressStartDetails longPressDetails)
      onLongPress;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => onPressed(context),
      onLongPressStart: (longPressDetails) =>
          onLongPress(context, longPressDetails),
      child: InkWell(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: min(screenWidth / 10, 20), vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(60)),
                  child: ZIMKitAvatar(
                    userID: conversation.id,
                    width: 60,
                    height: 60,
                  ),
                ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        conversation.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Builder(builder: (context) {
                        final defaultWidget =
                            defaultLastMessageBuilder(conversation.lastMessage);
                        return defaultWidget;
                      }),
                    ],
                  ),
                ),
              ),
              Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                Builder(builder: (context) {
                  final messageTime = conversation.lastMessage != null
                      ? DateTime.fromMillisecondsSinceEpoch(
                          conversation.lastMessage!.info.timestamp)
                      : null;
                  final defaultWidget =
                      defaultLastMessageTimeBuilder(messageTime);
                  return defaultWidget;
                }),
                const SizedBox(
                  height: 8,
                ),
                Builder(builder: (context) {
                  if (conversation.lastMessage != null) {
                    ZIMKitMessageBaseInfo info = conversation.lastMessage!.info;
                    if (info.direction == ZIMMessageDirection.send) {
                      if (info.sentStatus == ZIMMessageSentStatus.success) {
                        return const Icon(
                          Icons.check_circle,
                          size: 20,
                          color: Color(0xFFA4A2A2),
                        );
                      }
                      if (info.sentStatus == ZIMMessageSentStatus.failed) {
                        return const Icon(
                          Icons.check_circle_outline,
                          size: 20,
                          color: Color(0xFFA4A2A2),
                        );
                      }
                    } else {
                      if (conversation.unreadMessageCount != 0) {
                        return SizedBox(
                          width: 20,
                          height: 20,
                          child: CircleAvatar(
                            backgroundColor: primary60,
                            child: Text(
                              '${conversation.unreadMessageCount}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      }
                    }
                  }
                  return const SizedBox();
                }),
              ]),
            ],
          ),
        ),
      ),
    );
  }

  Widget defaultLastMessageBuilder(ZIMKitMessage? message) {
    if (message == null) {
      return const SizedBox.shrink();
    }
    final String content;
    if (message.info.direction == ZIMMessageDirection.receive) {
      if (conversation.type == ZIMConversationType.peer) {
        content = message.toStringValue();
      } else {
        content = "${message.info.senderUserID}: ${message.toStringValue()}";
      }
    } else {
      content = "Bạn: ${message.toStringValue()}";
    }
    return Opacity(
      opacity: conversation.unreadMessageCount != 0 ? 1 : 0.64,
      child: Text(
        content,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            fontSize: 14,
            fontWeight: conversation.unreadMessageCount != 0
                ? FontWeight.bold
                : FontWeight.normal),
      ),
    );
  }

  Widget defaultLastMessageTimeBuilder(DateTime? messageTime) {
    if (messageTime == null) {
      return const SizedBox.shrink();
    }
    final now = DateTime.now();
    final duration = DateTime.now().difference(messageTime);

    late String timeStr;

    if (duration.inMinutes < 1) {
      timeStr = 'Bây giờ';
    } else if (duration.inHours < 1) {
      timeStr = '${duration.inMinutes} phút trước';
    } else if (duration.inDays < 1) {
      timeStr = '${duration.inHours} giờ ';
    } else if (now.year == messageTime.year) {
      timeStr =
          '${messageTime.month}/${messageTime.day} ${messageTime.hour}:${messageTime.minute}';
    } else {
      timeStr =
          ' ${messageTime.year}/${messageTime.month}/${messageTime.day} ${messageTime.hour}:${messageTime.minute}';
    }

    return Opacity(
        opacity: 0.64,
        child: Text(timeStr, maxLines: 1, overflow: TextOverflow.clip));
  }
}
