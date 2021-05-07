import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:lions_den_app/screens/pages/messages/primary_message.dart';
import 'package:lions_den_app/theme/colors.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:jiffy/jiffy.dart';

import '../../../../dummy_data.dart';

class MessagesListItem extends StatelessWidget {
  const MessagesListItem({
    Key key,
    @required this.threads,
    @required this.index,
  }) : super(key: key);

  final List<MessageThread> threads;
  final int index;

  @override
  Widget build(BuildContext context) {
    final sender = threads[index].sender;
    return MessageThreadBody(
      child: GestureDetector(
        onTap: () {
          pushNewScreenWithRouteSettings(
            context,
            settings: RouteSettings(
                name: '/message',
                arguments: MessageScreenArguments(threads[index].threadID)),
            screen: MessageScreen(),
            pageTransitionAnimation: PageTransitionAnimation.cupertino,
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MessageThreadHeader(sender),
            const Divider(),
            Column(
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                          text: threads[index].sender.fName + ': ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: gradientBlue,
                          )),
                      TextSpan(text: threads[index].lastMessage.text),
                    ],
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(determineTimeSince(threads[index].lastMessage.timestamp)),
                IconButton(
                  icon: Icon(
                    FlutterIcons.arrow_right_fea,
                    color: slateGray,
                  ),
                  onPressed: () {
                    pushNewScreenWithRouteSettings(
                      context,
                      settings: RouteSettings(
                          name: '/message',
                          arguments:
                              MessageScreenArguments(threads[index].threadID)),
                      screen: MessageScreen(),
                      pageTransitionAnimation:
                          PageTransitionAnimation.cupertino,
                    );
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

String determineTimeSince(DateTime timestamp) {
  return Jiffy(timestamp).fromNow();
}

class MessageThreadHeader extends StatelessWidget {
  final DummyUser user;
  const MessageThreadHeader(
    this.user,
  );

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 2,
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.scaleDown,
                image: NetworkImage(user.profileImg),
              ),
              boxShadow: const [
                BoxShadow(
                  color: gunMetal,
                  offset: Offset(6, 6),
                )
              ],
            ),
          ),
        ),
        const Spacer(),
        Expanded(
          flex: 5,
          child: Container(
            padding: EdgeInsets.all(6),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: gunMetal,
                  offset: Offset(4, 4),
                )
              ],
              borderRadius: BorderRadius.circular(200.0),
              gradient: gradientPrimary,
            ),
            child: Text(
              user.fullName,
              maxLines: 1,
              softWrap: false,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                letterSpacing: 1,
                shadows: [
                  Shadow(blurRadius: 0, color: gunMetal, offset: Offset(1, 1))
                ],
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 15,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class MessageThreadBody extends StatelessWidget {
  final Widget child;
  const MessageThreadBody({@required this.child});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        width: size.width * 0.8,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: const [
              BoxShadow(
                color: gunMetal,
                offset: Offset(6, 6),
              )
            ],
            color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: child,
        ),
      ),
    );
  }
}
