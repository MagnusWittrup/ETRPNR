import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lions_den_app/logic/notifiers/swipe_notifier.dart';
import 'package:lions_den_app/theme/colors.dart';

import '../../../../dummy_data.dart';

class UserCardHeader extends StatelessWidget {
  final User user;
  const UserCardHeader(
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
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: gunMetal,
                  offset: Offset(6, 6),
                )
              ],
            ),
            child: CircleAvatar(
              radius: 36,
              backgroundColor: const Color.fromRGBO(40, 175, 176, 1.0),
              foregroundImage: NetworkImage(user.profileImg),
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
