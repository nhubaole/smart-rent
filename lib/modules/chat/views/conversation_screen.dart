import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/config/app_colors.dart';
import '/core/values/KEY_VALUE.dart';
import '/core/values/app_colors.dart';
import '/modules/chat/views/chat_screen.dart';
import '/modules/chat/views/conversation_item.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

class ConversationScreen extends StatelessWidget {
  const ConversationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primary40,
                  AppColors.primary95,
                ],
                begin: Alignment.topCenter,
                end: Alignment(0.0, -0.5),
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 62, horizontal: 24),
              child: Text(
                'Tin nhắn',
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          Positioned(
            top: 120,
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * 1,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: ZIMKitConversationListView(
                itemBuilder: (zkContext, ZIMKitConversation conversation,
                    defaultWidget) {
                  return Slidable(
                    key: Key('#conversation_${conversation.id}'),
                    startActionPane:
                        ActionPane(motion: const ScrollMotion(), children: [
                      SlidableAction(
                        // An action can be bigger than the others.
                        onPressed: (context) {
                          ZIMKit.instance.deleteConversation(
                              conversation.id, conversation.type,
                              isAlsoDeleteMessages: true);
                        },
                        backgroundColor: const Color(0xFFFE4A49),
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Delete',
                      ),
                    ]),
                    child: ConversationItem(
                      conversation: conversation,
                      onLongPress: (context, longPressDownDetails) => {},
                      onPressed: (BuildContext zContext) async {
                        var prefs = await SharedPreferences.getInstance();
                        String userId =
                            prefs.getString(KeyValue.KEY_ACCOUNT_PHONENUMBER) ??
                                '';
                        Get.to(
                          () => ChatScreen(
                            conversationID: conversation.id,
                            conversationName: conversation.name,
                            userId: userId,
                          ),
                        );
                      },
                    ),
                  );
                },
                emptyBuilder: (context, defaultWidget) => const Center(
                  child: Text('Bạn chưa có tin nhắn nào.'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
