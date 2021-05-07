import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lions_den_app/logic/notifiers/active_user_notifier.dart';
import 'package:lions_den_app/screens/auth/primary.dart';
import 'package:lions_den_app/theme/colors.dart';
import '../../../../dummy_data.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../swiper/components/BorderedGradientTetx.dart';
import 'SettingsCardHeader.dart';

class SettingsCardBody extends StatelessWidget {
  const SettingsCardBody({
    Key key,
    @required this.size,
    @required this.user,
  }) : super(key: key);

  final Size size;
  final DummyUser user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        // top: 35,
        bottom: 24,
      ),
      child: Container(
        width: size.width * 0.8,
        height: size.height * 0.7,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [
              BoxShadow(
                color: gunMetal,
                offset: Offset(6, 6),
              )
            ],
            color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SettingsCardHeader(user),
              const Divider(),
              ListTile(
                leading: const Icon(
                  FlutterIcons.log_out_fea,
                  color: slateGray,
                ),
                title: const GradientTextWithBorder(
                  text: 'Sign out',
                  fontSize: 20,
                ),
                onTap: () {
                  //Sign out
                  context.read(activeUserProvider).reset();
                },
              ),
              const Divider(),
              const ListTile(
                leading: Icon(
                  FlutterIcons.edit_fea,
                  color: slateGray,
                ),
                title: GradientTextWithBorder(
                  text: 'Edit profile',
                  fontSize: 20,
                ),
              ),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
