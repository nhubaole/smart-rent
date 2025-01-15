import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/core/enums/loading_type.dart';
import 'package:smart_rent/core/routes/app_routes.dart';
import 'package:smart_rent/core/widget/error_widget.dart';
import 'package:smart_rent/core/widget/loading_widget.dart';
import 'package:smart_rent/modules/chat/conversation_controller.dart';
import '/modules/chat/views/chat_screen.dart';
import '/modules/chat/views/conversation_item.dart';

class ConversationScreen extends GetView<ConversationController> {
  const ConversationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildBackground(context),
          Obx(() => _buildContent(context))
        ],
      ),
    );
  }

  Widget _buildBackground(BuildContext context) {
    return Container(
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
    );
  }

  Widget _buildContent(BuildContext context) {
    switch (controller.isLoadingData.value) {
      case LoadingType.LOADING:
        return const LoadingWidget();
      case LoadingType.ERROR:
        return const ErrorCustomWidget();
      case LoadingType.LOADED:
        return _buildConversationList(context);
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildConversationList(BuildContext context) {
    return Positioned(
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
            child: controller.conversations.isEmpty
                ? Center(
                    child: Text(
                      'no_conversations'.tr,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  )
                : ListView.builder(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                    itemCount: controller.conversations.length,
                    itemBuilder: (context, index) {
                      final conversation = controller.conversations[index];
                      return Slidable(
                        key: ValueKey('conversation_$index'),
                        startActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (_) {},
                              backgroundColor: const Color(0xFFFE4A49),
                              foregroundColor: Colors.white,
                              icon: Icons.delete,
                              label: 'delete'.tr,
                            ),
                          ],
                        ),
                        child: ConversationItem(
                          conversation: conversation,
                          onLongPress: (context, longPressDetails) {},
                          onPressed: (BuildContext zContext) async {
                            controller.onNavToChat(conversation);
                          },
                        ),
                      );
                    },
                  )));
  }
}
