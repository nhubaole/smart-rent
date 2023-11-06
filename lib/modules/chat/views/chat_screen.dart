import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemUiOverlayStyle, rootBundle;
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mime/mime.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:smart_rent/core/values/app_colors.dart';
import 'package:uuid/uuid.dart';
import 'package:zego_zim/zego_zim.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen(
      {super.key,
      required this.conversationID,
      required this.conversationName}) {
    ZIM.getInstance()!.clearConversationUnreadMessageCount(
        conversationID, ZIMConversationType.peer);
    clearUnReadMessage();
  }

  final String conversationID;
  final String conversationName;

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
  List<types.Message> _messages = [];
  final _user = types.User(
    id: "0823306992",
  );

  @override
  void initState() {
    super.initState();
    registerZIMEvent();
    if (widget._historyZIMMessageList.isEmpty) {
      queryMoreHistoryMessageList();
    }
  }

  @override
  void dispose() {
    unregisterZIMEvent();
    super.dispose();
  }

  queryMoreHistoryMessageList() async {
    if (widget.queryHistoryMsgComplete) {
      return;
    }

    ZIMMessageQueryConfig queryConfig = ZIMMessageQueryConfig();
    queryConfig.count = 20;
    queryConfig.reverse = true;
    try {
      queryConfig.nextMessage = widget._historyZIMMessageList.first;
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
      result.messageList.addAll(widget._historyZIMMessageList);
      widget._historyZIMMessageList = result.messageList;
      syncUIMessage();

      setState(() {});
    } catch (onError) {
      //log(onError.code);
    }
  }

  void syncUIMessage() async {
    for (ZIMMessage message in widget._historyZIMMessageList) {
      print("TYPE: " + message.type.name);
      switch (message.type) {
        case ZIMMessageType.text:
          ZIMTextMessage textMessage = message as ZIMTextMessage;
          final textMessageUI = types.TextMessage(
            author: types.User(
              id: message.senderUserID,
            ),
            createdAt: message.timestamp,
            id: const Uuid().v4(),
            text: textMessage.message,
          );
          _messages.insert(0, textMessageUI);
          break;
        case ZIMMessageType.image:
          try {
            ZIMImageMessage imageMessage = message as ZIMImageMessage;

            final imageMessageUI = types.ImageMessage(
              author: types.User(
                id: message.senderUserID,
              ),
              createdAt: message.timestamp,
              height: imageMessage.originalImageHeight.toDouble(),
              id: const Uuid().v4(),
              name: "name",
              size: 1000,
              uri: imageMessage.fileDownloadUrl,
              width: imageMessage.originalImageWidth.toDouble(),
            );
            _messages.insert(0, imageMessageUI);
          } catch (e) {
            print(e);
          }
          break;
        case ZIMMessageType.file:
          ZIMFileMessage fileMessage = message as ZIMFileMessage;
          final fileMessageUI = types.FileMessage(
            author: types.User(
              id: message.senderUserID,
            ),
            createdAt: message.timestamp,
            id: const Uuid().v4(),
            mimeType: lookupMimeType(fileMessage.fileLocalPath),
            name: fileMessage.fileName,
            size: fileMessage.fileSize,
            uri: fileMessage.fileDownloadUrl,
          );
          _messages.insert(0, fileMessageUI);
          break;
        default:
          break;
      }
    }
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
          height: 144,
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
                  child: Text('Photo'),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _handleFileSelection();
                },
                child: const Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text('File'),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text('Cancel'),
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

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: message.text,
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
      syncUIMessage();
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
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          toolbarHeight: 64.0,
          centerTitle: true,
          title: Text(
            widget.conversationName,
            style: TextStyle(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.light,
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
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
        body: Chat(
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
        ),
      );

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
