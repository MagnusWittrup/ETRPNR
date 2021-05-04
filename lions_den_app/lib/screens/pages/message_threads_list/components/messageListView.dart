import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lions_den_app/logic/notifiers/accepted_users_notifer.dart';

import '../../../../dummy_data.dart';
import 'messageListItem.dart';

class MessagesListWiew extends ConsumerWidget {
  const MessagesListWiew();

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final acceptedProvider = watch(acceptedUserListProvider);
    final acceptedUsers = acceptedProvider.acceptedUsers;

    final dummyThreads = DummyData().dummyThreads;

    final threads = acceptedUsers
        .map((user) => dummyThreads
            .firstWhere((thread) => thread.threadID == user.threadId))
        .toList();

    if (threads.isEmpty) {
      return const Center(
        child: Text('No messages'),
      );
    }
    return Expanded(
      child: ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: threads.length,
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemBuilder: (context, index) {
          return MessagesListItem(
            threads: threads,
            index: index,
          );
        },
      ),
    );
  }
}
