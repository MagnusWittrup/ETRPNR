import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lions_den_app/theme/colors.dart';
import 'package:simple_animations/simple_animations.dart';

import '../../../dummy_data.dart';
import '../../../logic/notifiers/users_notifer.dart';
import 'components/DragableCard.dart';
import 'components/UserCard.dart';

class SwiperPage extends StatefulWidget {
  const SwiperPage({Key key}) : super(key: key);

  @override
  _SwiperPageState createState() => _SwiperPageState();
}

class _SwiperPageState extends State<SwiperPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: gradientPrimary,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Consumer(
          builder: (context, watch, child) {
            final users = watch(userListProvider).users;
            return users.isEmpty
                ? const Text('No more users')
                : Stack(
                    alignment: Alignment.center,
                    children: users
                        .map(
                          (user) => DraggableCard(
                            user: user,
                            child: UserCard(
                              user,
                            ),
                          ),
                        )
                        .toList(),
                  );
          },
        ),
      ),
    );
  }
}
