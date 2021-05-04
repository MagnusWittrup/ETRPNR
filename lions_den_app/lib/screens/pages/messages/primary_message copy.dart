import 'package:flutter/material.dart';
import 'package:lions_den_app/theme/colors.dart';

import '../../../dummy_data.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen();
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context).settings.arguments as MessageScreenArguments;

    final messageThread = DummyData()
        .dummyThreads
        .firstWhere((element) => element.threadID == args.id);
    return Scaffold(
      backgroundColor: slateGray,
      appBar: AppBar(
        title: Text(args.id.toString()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              messageThread.messages.length,
              (index) {
                final currentMessage = messageThread.messages[index];
                if (index == 0 ||
                    messageThread.messages[index - 1].sender !=
                        currentMessage.sender) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MessageHeader(currentMessage.sender),
                      MessageBody(
                        text: currentMessage.text,
                        timestamp: currentMessage.timestamp,
                      ),
                    ],
                  );
                }
                return MessageBody(
                  text: currentMessage.text,
                  timestamp: currentMessage.timestamp,
                );
              },
            )),
      ),
    );
  }
}

class MessageScreenArguments {
  final int id;

  MessageScreenArguments(this.id);
}

class MessageHeader extends StatelessWidget {
  final String name;
  const MessageHeader(this.name);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: gunMetal,
              offset: Offset(4, 4),
            )
          ],
          borderRadius: BorderRadius.circular(200.0),
          gradient: gradientPrimary,
        ),
        child: Text(
          name,
          maxLines: 1,
          softWrap: false,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: const TextStyle(
            letterSpacing: 1,
            shadows: [Shadow(color: gunMetal, offset: Offset(1, 1))],
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}

class MessageBody extends StatelessWidget {
  final String text;
  final DateTime timestamp;
  const MessageBody({
    this.text,
    this.timestamp,
  });

  @override
  Widget build(BuildContext context) {
    final timestampText = determineTimeElapsedSinceMessage(timestamp);
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  color: gunMetal,
                  offset: Offset(4, 4),
                )
              ],
              borderRadius: BorderRadius.circular(200.0),
            ),
            child: Text(
              text,
              softWrap: false,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: gunMetal,
                fontSize: 15,
              ),
            ),
          ),
          Text(timestampText)
        ],
      ),
    );
  }
}

String determineTimeElapsedSinceMessage(DateTime timestamp) {
  final _now = DateTime.now();
  final diff = timestamp.difference(_now);
  return diff.toString();
}
