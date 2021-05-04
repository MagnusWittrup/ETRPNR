import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lions_den_app/logic/notifiers/swipe_notifier.dart';
import 'package:lions_den_app/theme/colors.dart';

import '../../../../dummy_data.dart';
import 'UserCardBody.dart';
import 'UserCardButtons.dart';
import 'UserCardHeader.dart';

class UserCard extends StatelessWidget {
  final User user;
  const UserCard(
    this.user,
  );

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer(builder: (context, watch, child) {
      final swipeState = watch(swipeStateProvider);
      bool isAccepting = false;
      bool isDeclining = false;

      if (swipeState is SwipeStateAccept) {
        if (swipeState.activeUser == user) {
          isAccepting = true;
        }
      }

      if (swipeState is SwipeStateDecline) {
        if (swipeState.activeUser == user) {
          isDeclining = true;
        }
      }

      return Stack(
        alignment: Alignment.topCenter,
        children: [
          CardBody(size: size, user: user),
          // _determineShaderMask(size, user, isAccepting, isDeclining),
          _determineOpacity(size, user, isAccepting, isDeclining),
          _determineOverlayIcon(size, user, isAccepting, isDeclining),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child:
                  SizedBox(width: size.width * 0.8, child: CardButtons(user)),
            ),
          ),
        ],
      );
    });
  }
}

class FeedBackOverlay extends StatelessWidget {
  final Widget child;
  final AlignmentGeometry alignment;
  const FeedBackOverlay({@required this.child, @required this.alignment});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Align(
        alignment: alignment,
        child: child,
      ),
    );
  }
}

Widget _determineOpacity(
    Size size, User user, bool isAccepting, bool isDeclining) {
  if (!(isAccepting || isDeclining)) return Text('');
  if (isAccepting) {
    return Opacity(
      opacity: 0.4,
      child: EmptyCardBody(size: size, color: gradientGreen),
    );
  }
  return Opacity(
    opacity: 0.4,
    child: EmptyCardBody(size: size, color: red),
  );
}

Widget _determineShaderMask(
    Size size, User user, bool isAccepting, bool isDeclining) {
  if (!(isAccepting || isDeclining)) return Text('');
  if (isAccepting) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return RadialGradient(
          center: Alignment.topLeft,
          radius: 1.0,
          colors: <Color>[Colors.yellow, Colors.deepOrange.shade900],
          tileMode: TileMode.mirror,
        ).createShader(bounds);
      },
      child: EmptyCardBody(
        size: size,
      ),
    );
  }
  return ShaderMask(
    shaderCallback: (Rect bounds) {
      return RadialGradient(
        center: Alignment.topLeft,
        radius: 1.0,
        colors: <Color>[Colors.yellow, Colors.deepOrange.shade900],
        tileMode: TileMode.mirror,
      ).createShader(bounds);
    },
    child: EmptyCardBody(
      size: size,
    ),
  );
}

Widget _determineOverlayIcon(
    Size size, User user, bool isAccepting, bool isDeclining) {
  if (!(isAccepting || isDeclining)) return Text('');
  if (isAccepting) {
    return FeedBackOverlay(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircularIconButton(
          color: lightGreen,
          iconData: FlutterIcons.check_circle_fea,
          onPressed: () => {},
        ),
      ),
    );
  }
  return FeedBackOverlay(
    alignment: Alignment.topRight,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: CircularIconButton(
        color: red,
        iconData: FlutterIcons.x_circle_fea,
        onPressed: () => {},
      ),
    ),
  );
}
