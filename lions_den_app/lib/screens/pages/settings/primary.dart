import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:lions_den_app/logic/notifiers/active_user_notifier.dart';
import 'package:lions_den_app/screens/pages/settings/components/SettingsCardBody.dart';
import 'package:lions_den_app/theme/colors.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final size = MediaQuery.of(context).size;
    final user = watch(activeUserProvider).user;
    return Container(
      decoration: const BoxDecoration(
        gradient: gradientPrimary,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: SettingsCardBody(size: size, user: user),
        ),
      ),
    );
  }
}
