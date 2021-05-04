import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:lions_den_app/screens/pages/swiper/components/BorderedGradientTetx.dart';
import 'package:lions_den_app/theme/colors.dart';
import 'package:uuid/uuid.dart';

import '../../../dummy_data.dart';

class MessageScreenArguments {
  final int id;

  MessageScreenArguments(this.id);
}

class MessageScreen extends StatefulWidget {
  const MessageScreen();

  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  List<types.Message> _messages = [];
  final _user = const types.User(id: '06c33e8b-e835-4736-80f4-63f44b66666c');

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  void _handleMessageTap(types.Message message) async {}

  void _handlePreviewDataFetched(
    types.TextMessage message,
    types.PreviewData previewData,
  ) {
    final index = _messages.indexWhere((element) => element.id == message.id);
    final currentMessage = _messages[index] as types.TextMessage;
    final updatedMessage = currentMessage.copyWith(previewData: previewData);

    setState(() {
      _messages[index] = updatedMessage;
    });
  }

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      authorId: _user.id,
      id: const Uuid().v4(),
      text: message.text,
      timestamp: (DateTime.now().millisecondsSinceEpoch / 1000).floor(),
    );

    _addMessage(textMessage);
  }

  void _loadMessages() async {
    final response = await rootBundle.loadString('assets/messages.json');
    final messages = (jsonDecode(response) as List)
        .map((e) => types.Message.fromJson(e as Map<String, dynamic>))
        .toList();

    setState(() {
      _messages = messages;
    });
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context).settings.arguments as MessageScreenArguments;

    final messageThread = DummyData()
        .dummyThreads
        .firstWhere((element) => element.threadID == args.id);

    final sender = messageThread.sender;

    return Container(
      decoration: const BoxDecoration(
        gradient: gradientPrimary,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(10),
            ),
          ),
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(
            color: slateGray,
          ),
          title: GradientTextWithBorder(
            text: sender.fullName,
            fontSize: 25,
          ),
          actions: [
            IconButton(
              icon: const Icon(FlutterIcons.user_fea),
              onPressed: () {},
            ),
          ],
        ),
        body: Chat(
          theme: const DefaultChatTheme(
            primaryColor: gradientBlue,
            backgroundColor: Colors.transparent,
            captionColor: gunMetal,
          ),
          messages: _messages,
          disableImageGallery: true,
          onPreviewDataFetched: _handlePreviewDataFetched,
          onSendPressed: _handleSendPressed,
          user: _user,
        ),
      ),
    );
  }
}
