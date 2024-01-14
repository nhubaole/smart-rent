import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemUiOverlayStyle, rootBundle;
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:smart_rent/core/model/account/Account.dart';
import 'package:smart_rent/core/resources/auth_methods.dart';
import 'package:smart_rent/core/resources/firebase_fcm.dart';
import 'package:smart_rent/core/resources/firestore_methods.dart';
import 'package:smart_rent/core/values/app_colors.dart';
import 'package:uuid/uuid.dart';
import 'package:zego_zim/zego_zim.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

// ignore: must_be_immutable
class ChatScreen extends StatefulWidget {
  ChatScreen(
      {super.key,
      required this.conversationID,
      required this.conversationName,
      required this.userId}) {
    clearUnReadMessage();
  }

  final String conversationID;
  final String conversationName;
  final String userId;

  String imgUrl = '';

  ScrollController scrollController = ScrollController();

  List<ZIMMessage> _historyZIMMessageList = <ZIMMessage>[];

  bool queryHistoryMsgComplete = false;

  clearUnReadMessage() {
    ZIM.getInstance()!.clearConversationUnreadMessageCount(
        conversationID, ZIMConversationType.peer);
  }

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late Account currentAccount;
  List<types.Message> _messages = [];
  List<String> suggest = [
    "Phòng này còn không ạ?",
    "Khi nào mình đi xem phòng được?",
    "Cảm ơn nhưng tôi không thích phòng này."
  ];
  var _user;
  Future<void> getCurrentAccount() async {
    currentAccount = await AuthMethods.getUserDetails(
        FirebaseAuth.instance.currentUser!.uid);
  }

  @override
  void initState() {
    super.initState();
    getCurrentAccount();
    _user = types.User(
      id: widget.userId,
    );
    queryAvatar();

    registerZIMEvent();
    if (widget._historyZIMMessageList.isEmpty) {
      queryMoreHistoryMessageList();
    }
  }

  void queryAvatar() async {
    ZIMUserFullInfo u = await ZIMKit().queryUser(widget.conversationID);
    widget.imgUrl = u.userAvatarUrl;
  }

  @override
  void dispose() {
    unregisterZIMEvent();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          toolbarHeight: 64.0,
          centerTitle: true,
          title: Text(
            widget.conversationName,
            style: const TextStyle(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.light,
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: primary80,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  primary40,
                  primary80,
                ],
              ),
            ),
          ),
          elevation: 0,
          automaticallyImplyLeading: true,
          titleSpacing: 0,
          iconTheme: const IconThemeData(color: primary40),
        ),
        body: Scrollbar(
          controller: widget.scrollController,
          child: NotificationListener(
            onNotification: (ScrollNotification notification) {
              double progressMedian = notification.metrics.pixels /
                  notification.metrics.maxScrollExtent;
              int progress = (progressMedian * 100).toInt();

              if (progress >= 90) {
                queryMoreHistoryMessageList();
              }
              return false;
            },
            child: Chat(
                messages: _messages,
                onAttachmentPressed: _handleAttachmentPressed,
                onMessageTap: _handleMessageTap,
                onPreviewDataFetched: _handlePreviewDataFetched,
                onSendPressed: _handleSendPressed,
                showUserAvatars: true,
                showUserNames: true,
                user: _user,
                theme: const DefaultChatTheme(
                  inputBackgroundColor: primary40,
                  inputTextColor: Colors.white,
                  primaryColor: primary60,
                  secondaryColor: secondary90,
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              backgroundColor: primary40,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                            onPressed: () {
                              _handleSendPressed(
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
                      onAttachmentPressed: _handleAttachmentPressed,
                      onSendPressed: _handleSendPressed,
                    ),
                  ],
                )),
          ),
        ),
      );

  queryMoreHistoryMessageList() async {
    //await getUser();
    print("queryHistoryMsgComplete: " +
        widget.queryHistoryMsgComplete.toString());

    if (widget.queryHistoryMsgComplete) {
      return;
    }

    ZIMMessageQueryConfig queryConfig = ZIMMessageQueryConfig();
    queryConfig.count = 20;
    queryConfig.reverse = true;
    try {
      queryConfig.nextMessage = widget._historyZIMMessageList.first;
      if (widget._historyZIMMessageList.first.type == ZIMMessageType.text) {
        ZIMTextMessage textMessage =
            widget._historyZIMMessageList.first as ZIMTextMessage;
        print("========nextMessage: " + textMessage.message);
      }
    } catch (onerror) {
      queryConfig.nextMessage = null;
    }
    try {
      ZIMMessageQueriedResult result = await ZIM
          .getInstance()!
          .queryHistoryMessage(
              widget.conversationID, ZIMConversationType.peer, queryConfig);
      if (result.messageList.length < 20) {
        widget.queryHistoryMsgComplete = true;
      }
      List<types.Message> oldMessageWidgetList =
          convertMessageToWidget(result.messageList);

      result.messageList.addAll(widget._historyZIMMessageList);
      widget._historyZIMMessageList = result.messageList;

      for (var item in widget._historyZIMMessageList) {
        if (item.type == ZIMMessageType.text) {
          ZIMTextMessage textMessage = item as ZIMTextMessage;
          print("ITEM: " + textMessage.message);
        }
      }

      _messages.addAll(oldMessageWidgetList);

      setState(() {});
    } catch (onError) {
      //log(onError.code);
    }
  }

  List<types.Message> convertMessageToWidget(List<ZIMMessage> messageList) {
    List<types.Message> widgets = [];

    for (ZIMMessage message in messageList) {
      switch (message.type) {
        case ZIMMessageType.text:
          ZIMTextMessage textMessage = message as ZIMTextMessage;
          final textMessageUI = types.TextMessage(
            author:
                types.User(id: message.senderUserID, imageUrl: widget.imgUrl),
            createdAt: message.timestamp,
            id: const Uuid().v4(),
            text: textMessage.message,
          );
          widgets.insert(0, textMessageUI);
          break;
        case ZIMMessageType.image:
          try {
            ZIMImageMessage imageMessage = message as ZIMImageMessage;

            final imageMessageUI = types.ImageMessage(
              author:
                  types.User(id: message.senderUserID, imageUrl: widget.imgUrl),
              createdAt: message.timestamp,
              height: imageMessage.originalImageHeight.toDouble(),
              id: const Uuid().v4(),
              name: "name",
              size: 1000,
              uri: imageMessage.fileDownloadUrl,
              width: imageMessage.originalImageWidth.toDouble(),
            );
            widgets.insert(0, imageMessageUI);
          } catch (e) {
            print(e);
          }
          break;
        case ZIMMessageType.file:
          ZIMFileMessage fileMessage = message as ZIMFileMessage;
          final fileMessageUI = types.FileMessage(
            author:
                types.User(id: message.senderUserID, imageUrl: widget.imgUrl),
            createdAt: message.timestamp,
            id: const Uuid().v4(),
            mimeType: lookupMimeType(fileMessage.fileLocalPath),
            name: fileMessage.fileName,
            size: fileMessage.fileSize,
            uri: fileMessage.fileDownloadUrl,
          );
          widgets.insert(0, fileMessageUI);
          break;
        default:
          break;
      }
    }
    return widgets;
  }

  void _addMessage(types.Message message) {
    switch (message.type) {
      case MessageType.text:
        types.TextMessage m = message as types.TextMessage;
        sendTextMessage(m.text);
        break;

      case MessageType.image:
        types.ImageMessage m = message as types.ImageMessage;
        sendMediaMessage(m.uri, ZIMMessageType.image);
        break;

      case MessageType.file:
        types.FileMessage m = message as types.FileMessage;
        sendMediaMessage(m.uri, ZIMMessageType.file);
        break;

      default:
        break;
    }
    setState(() {
      _messages.insert(0, message);
    });
  }

  void _handleAttachmentPressed() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) => SafeArea(
        child: SizedBox(
          height: 96,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _handleImageSelection();
                },
                child: const Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text('Hình ảnh'),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _handleFileSelection();
                },
                child: const Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text('Tệp đính kèm'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleFileSelection() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );

    if (result != null && result.files.single.path != null) {
      final message = types.FileMessage(
        author: _user,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: const Uuid().v4(),
        mimeType: lookupMimeType(result.files.single.path!),
        name: result.files.single.name,
        size: result.files.single.size,
        uri: result.files.single.path!,
      );

      _addMessage(message);
    }
  }

  void _handleImageSelection() async {
    final result = await ImagePicker().pickImage(
      imageQuality: 70,
      maxWidth: 1440,
      source: ImageSource.gallery,
    );

    if (result != null) {
      final bytes = await result.readAsBytes();
      final image = await decodeImageFromList(bytes);

      final message = types.ImageMessage(
        author: _user,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        height: image.height.toDouble(),
        id: const Uuid().v4(),
        name: result.name,
        size: bytes.length,
        uri: result.path,
        width: image.width.toDouble(),
      );

      _addMessage(message);
    }
  }

  void _handleMessageTap(BuildContext _, types.Message message) async {
    if (message is types.FileMessage) {
      var localPath = message.uri;

      if (message.uri.startsWith('http')) {
        try {
          final index =
              _messages.indexWhere((element) => element.id == message.id);
          final updatedMessage =
              (_messages[index] as types.FileMessage).copyWith(
            isLoading: true,
          );

          setState(() {
            _messages[index] = updatedMessage;
          });

          final client = http.Client();
          final request = await client.get(Uri.parse(message.uri));
          final bytes = request.bodyBytes;
          final documentsDir = (await getApplicationDocumentsDirectory()).path;
          localPath = '$documentsDir/${message.name}';

          if (!File(localPath).existsSync()) {
            final file = File(localPath);
            await file.writeAsBytes(bytes);
          }
        } finally {
          final index =
              _messages.indexWhere((element) => element.id == message.id);
          final updatedMessage =
              (_messages[index] as types.FileMessage).copyWith(
            isLoading: null,
          );

          setState(() {
            _messages[index] = updatedMessage;
          });
        }
      }

      await OpenFilex.open(localPath);
    }
  }

  void _handlePreviewDataFetched(
    types.TextMessage message,
    types.PreviewData previewData,
  ) {
    final index = _messages.indexWhere((element) => element.id == message.id);
    final updatedMessage = (_messages[index] as types.TextMessage).copyWith(
      previewData: previewData,
    );

    setState(() {
      _messages[index] = updatedMessage;
    });
  }

  Future<void> _handleSendPressed(types.PartialText message) async {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: message.text,
    );

    String fcmToken = await FireStoreMethods()
        .getTokenDeviceByPhoneNumber(widget.conversationID);
    await FirebaseFCM().sendNotificationHTTP(
      FirebaseAuth.instance.currentUser!.uid,
      'receiverId',
      fcmToken,
      'Tin nhắn mới từ ${currentAccount.username}',
      message.text,
      true,
      'imgUrl',
      'MESSAGE',
      {},
    );
    _addMessage(textMessage);
  }

  registerZIMEvent() {
    ZIMEventHandler.onMessageSentStatusChanged =
        (zim, messageSentStatusChangedInfoList) {
      for (var element in messageSentStatusChangedInfoList) {
        print(
            "sentStatus:${element.status},message:${(element.message as ZIMTextMessage).message}");
      }
    };
    ZIMEventHandler.onReceivePeerMessage = (zim, messageList, fromUserID) {
      if (fromUserID != widget.conversationID) {
        return;
      }
      widget.clearUnReadMessage();
      widget._historyZIMMessageList.addAll(messageList);

      List<types.Message> cells = convertMessageToWidget(messageList);
      _messages.insertAll(0, cells);

      setState(() {});
    };

    ZIMEventHandler.onReceiveGroupMessage = (zim, messageList, fromUserID) {
      if (fromUserID != widget.conversationID) {
        return;
      }
      widget.clearUnReadMessage();
      widget._historyZIMMessageList.addAll(messageList);

      List<types.Message> cells = convertMessageToWidget(messageList);
      _messages.insertAll(0, cells);

      setState(() {});
    };

    ZIMEventHandler.onMessageSentStatusChanged = (zim, infos) {
      //window.console.warn(infos);
    };

    ZIMEventHandler.onMessageDeleted = (zim, deletedInfo) {};

    ZIMEventHandler.onUserInfoUpdated = (zim, info) {};
  }

  unregisterZIMEvent() {
    ZIMEventHandler.onReceivePeerMessage = null;
    ZIMEventHandler.onMessageSentStatusChanged = null;
    ZIMEventHandler.onReceiveGroupMessage = null;
  }

  sendTextMessage(String message) async {
    ZIMTextMessage textMessage = ZIMTextMessage(message: message);
    textMessage.senderUserID = _user.id;
    ZIMMessageSendConfig sendConfig = ZIMMessageSendConfig();
    widget._historyZIMMessageList.add(textMessage);
    try {
      ZIMMessageSentResult result = await ZIM.getInstance()!.sendMessage(
          textMessage,
          widget.conversationID,
          ZIMConversationType.peer,
          sendConfig,
          ZIMMessageSendNotification(onMessageAttached: ((message) async {})));

      int index = widget._historyZIMMessageList
          .lastIndexWhere((element) => element == textMessage);
      widget._historyZIMMessageList[index] = result.message;
    } catch (onError) {
      print('send error');
      setState(() {
        int index = widget._historyZIMMessageList
            .lastIndexWhere((element) => element == textMessage);
        widget._historyZIMMessageList[index].sentStatus =
            ZIMMessageSentStatus.failed;
      });
    }
  }

  sendMediaMessage(String? path, ZIMMessageType messageType) async {
    if (path == null) return;
    ZIMMediaMessage mediaMessage = mediaMessageFactory(path, messageType);
    mediaMessage.senderUserID = _user.id;

    setState(() {
      widget._historyZIMMessageList.add(mediaMessage);
    });
    try {
      print(mediaMessage.fileLocalPath);
      ZIMMediaMessageSendNotification notification =
          ZIMMediaMessageSendNotification(
        onMediaUploadingProgress: (message, currentFileSize, totalFileSize) {
          print("totalFileSize: ${totalFileSize}");
        },
      );
      ZIMMessageSentResult result = await ZIM.getInstance()!.sendMediaMessage(
          mediaMessage,
          widget.conversationID,
          ZIMConversationType.peer,
          ZIMMessageSendConfig(),
          notification);
      int index = widget._historyZIMMessageList
          .lastIndexWhere((element) => element == mediaMessage);
      widget._historyZIMMessageList[index] = result.message;
    } catch (onError) {
      setState(() {
        int index = widget._historyZIMMessageList
            .lastIndexWhere((element) => element == mediaMessage);
        widget._historyZIMMessageList[index].sentStatus =
            ZIMMessageSentStatus.failed;
      });
    }
  }

  ZIMMediaMessage mediaMessageFactory(String path, ZIMMessageType messageType) {
    ZIMMediaMessage mediaMessage;

    switch (messageType) {
      case ZIMMessageType.image:
        mediaMessage = ZIMImageMessage(path);
        break;
      case ZIMMessageType.video:
        mediaMessage = ZIMVideoMessage(path);
        break;
      case ZIMMessageType.audio:
        mediaMessage = ZIMAudioMessage(path);

        break;
      case ZIMMessageType.file:
        mediaMessage = ZIMFileMessage(path);
        break;
      default:
        {
          throw UnimplementedError();
        }
    }
    return mediaMessage;
  }
}
