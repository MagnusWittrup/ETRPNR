import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lions_den_app/dummy_data.dart';
import 'package:lions_den_app/logic/notifiers/users_notifer.dart';
import 'package:lions_den_app/theme/colors.dart';

class CardButtons extends StatelessWidget {
  final User user;
  const CardButtons(this.user);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CircularIconButton(
          color: red,
          iconData: FlutterIcons.x_circle_fea,
          onPressed: () {
            context.read(userListProvider.notifier).remove(user);
          },
        ),
        // CircularIconButton(
        //   color: gradientBlue,
        //   iconData: FlutterIcons.plus_circle_fea,
        //   onPressed: () => {},
        // ),
        CircularIconButton(
          color: lightGreen,
          iconData: FlutterIcons.check_circle_fea,
          onPressed: () {
            context.read(userListProvider.notifier).accept(user);
            context.read(userListProvider.notifier).remove(user);
          },
        ),
      ],
    );
  }
}

class CircularIconButton extends StatelessWidget {
  final Color color;
  final Function() onPressed;
  final IconData iconData;

  const CircularIconButton({
    @required this.color,
    @required this.onPressed,
    @required this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: gunMetal,
            offset: Offset(6, 6),
          )
        ],
      ),
      child: InkWell(
        splashColor: Colors.red, // inkwell color
        child: SizedBox(
            width: 56,
            height: 56,
            child: Icon(
              iconData,
              color: Colors.white,
            )),
        onTap: onPressed,
      ),
    );

    return Container(
      width: 30,
      height: 30,
      child: MaterialButton(
        elevation: 0,
        onPressed: () {},
        color: color,
        textColor: Colors.white,
        padding: const EdgeInsets.all(16),
        child: Icon(
          iconData,
          size: 24,
        ),
      ),
    );
  }
}
