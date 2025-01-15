import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:get/get.dart';
import 'package:smart_rent/core/app/app_manager.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/modules/chat/chat_controller.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';

class ChatScreen extends GetView<ChatController> {
  final List<String> suggest = [
    "Phòng này còn không ạ?",
    "Khi nào mình đi xem phòng được?",
    "Cảm ơn nhưng tôi không thích phòng này."
  ];

  ChatScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          backgroundColor: Colors.white,
          leading: InkWell(
            onTap: () => Get.back(),
            child: Icon(Icons.arrow_back),
          ),
          titleSpacing: 0,
          title: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(controller.companionAvatarUrl),
              ),
              SizedBox(
                width: 8,
              ),
              Expanded(
                child: Text(
                  controller.companionName,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          centerTitle: false,
          actions: [
            InkWell(
              onTap: () async {},
              child: Container(
                margin: EdgeInsets.only(right: 4),
                padding: EdgeInsets.all(4),
                child: Icon(Icons.more_vert),
              ),
            ),
          ],
        ),
        body: Obx(
          () => Chat(
              customMessageBuilder: (customMessage, {required messageWidth}) {
                final metadata = customMessage.metadata;
                final isMine = customMessage.author.id == AppManager.instance.currentUser?.id.toString();

                if (metadata == null) return const SizedBox.shrink();

                return Container(
                  width: messageWidth * 1.0,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Yêu cầu thuê phòng của bạn đã được tiếp nhận",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: isMine ? Colors.white : AppColors.secondary20,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isMine ? AppColors.primary98 : AppColors.secondary80,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              metadata['room_title'] ?? '',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              metadata['room_address'] ?? '',
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppColors.secondary20,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        "Bạn có thể trao đổi thêm chi tiết hoặc đặt lịch xem phòng trực tiếp tại đây",
                        style: TextStyle(
                          fontSize: 14,
                          color: isMine ? Colors.white : AppColors.black,
                        ),
                      ),
                    ],
                  ),
                );
              },
              messages: controller.messages.toList(),
              onAttachmentPressed: controller.handleAttachmentPressed,
              onMessageTap: controller.handleMessageTap,
              onPreviewDataFetched: controller.handlePreviewDataFetched,
              onSendPressed: controller.handleSendPressed,
              showUserAvatars: true,
              showUserNames: true,
              user: controller.currentUser,
              theme: const DefaultChatTheme(
                inputBackgroundColor: AppColors.primary40,
                inputTextColor: Colors.white,
                primaryColor: AppColors.primary60,
                secondaryColor: AppColors.secondary90,
              ),
              customBottomWidget: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
                    height: 40,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return FilledButton(
                          style: FilledButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            backgroundColor: AppColors.primary40,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                          onPressed: () {
                            controller.handleSendPressed(
                                PartialText(text: suggest[index]));
                          },
                          child: Text(
                            suggest[index],
                            style: const TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        );
                      },
                      itemCount: suggest.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(width: 8);
                      },
                    ),
                  ),
                  Input(
                    isAttachmentUploading: false,
                    onAttachmentPressed: () {},
                    onSendPressed: controller.handleSendPressed,
                  ),
                ],
              )),
        ),
      );
}
