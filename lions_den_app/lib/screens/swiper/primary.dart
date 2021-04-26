import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:lions_den_app/dummy_data.dart';
import 'package:lions_den_app/models/auth.dart';
import 'package:provider/provider.dart';

import 'components/UserCard.dart';

class SwiperScreen extends StatefulWidget {
  const SwiperScreen({Key key}) : super(key: key);

  @override
  _SwiperScreenState createState() => _SwiperScreenState();
}

class _SwiperScreenState extends State<SwiperScreen> {
  final users = DummyData().dummyUsers;
  var acceptedUsers = <User>[];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(40, 175, 176, 1.0),
              Color.fromRGBO(166, 207, 173, 1.0),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Color(0xff252627),
            leading: IconButton(
              icon: const Icon(FlutterIcons.log_out_fea),
              onPressed: () {
                context.read<AuthModel>().logout();
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
            centerTitle: true,
          ),
          // bottomNavigationBar: BottomNavigationBar(
          //   items: const [
          //     BottomNavigationBarItem(
          //       icon: Icon(FlutterIcons.message_circle_fea),
          //       label: '',
          //     )
          //   ],
          // ),
          body: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                users.isEmpty
                    ? const Text('No more users')
                    : Stack(
                        alignment: Alignment.center,
                        children: users.map(buildUser).toList(),
                      ),
                Expanded(child: Container()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildUser(User user) {
    return Listener(
      onPointerMove: (pointerEvent) {
        // final provider =
        //     Provider.of<FeedbackPositionProvider>(context, listen: false);
        // provider.updatePosition(pointerEvent.localDelta.dx);
      },
      onPointerCancel: (_) {
        // final provider =
        //     Provider.of<FeedbackPositionProvider>(context, listen: false);
        // provider.resetPosition();
      },
      onPointerUp: (_) {
        // final provider =
        //     Provider.of<FeedbackPositionProvider>(context, listen: false);
        // provider.resetPosition();
      },
      child: Draggable(
        feedback: Material(
          color: Colors.transparent,
          child: UserCard(
            user,
          ),
        ),
        childWhenDragging: Container(),
        onDragEnd: (details) => onDragEnd(details, user),
        child: UserCard(
          user,
        ),
      ),
    );
  }

  void onDragEnd(DraggableDetails details, User user) {
    const minimumDrag = 100;
    if (details.offset.dx > minimumDrag) {
      user.isAcceptedByMe = true;
      acceptedUsers.add(user);
      debugPrint('ACCEPT');
      setState(() => users.remove(user));
    } else if (details.offset.dx < -minimumDrag) {
      user.isAcceptedByMe = false;
      debugPrint('REFUSE');
      setState(() => users.remove(user));
    }
  }
}
