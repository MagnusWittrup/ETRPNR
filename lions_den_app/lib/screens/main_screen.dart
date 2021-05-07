import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:lions_den_app/logic/notifiers/accepted_users_notifer.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../theme/colors.dart';
import 'pages/message_threads_list/primary_message_threads_list.dart';
import 'pages/settings/primary.dart';
import 'pages/swiper/primary.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

final _controller = PersistentTabController(initialIndex: 1);
final _key = GlobalKey<ScaffoldState>();

class _MainScreenState extends State<MainScreen> {
  final _widgetOptions = const [
    MessagesPage(),
    SwiperPage(),
    SettingsPage(),
  ];

  final _navbarItems = [
    PersistentBottomNavBarItem(
      icon: Icon(FlutterIcons.message_circle_fea),
      title: 'Messages',
      activeColorPrimary: gradientBlue,
      inactiveColorPrimary: slateGray,
    ),
    PersistentBottomNavBarItem(
      icon: Icon(FlutterIcons.dollar_sign_fea),
      title: 'Swiper',
      activeColorPrimary: gradientBlue,
      inactiveColorPrimary: slateGray,
    ),
    PersistentBottomNavBarItem(
      activeColorPrimary: gradientBlue,
      icon: Icon(FlutterIcons.settings_fea),
      title: 'settings',
      inactiveColorPrimary: slateGray,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: PersistentTabView(
        context,
        key: _key,
        controller: _controller,
        screens: _widgetOptions,
        items: _navbarItems,
        resizeToAvoidBottomInset: true,
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(10.0),
          colorBehindNavBar: Colors.white,
        ),
        itemAnimationProperties: const ItemAnimationProperties(
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation(
          animateTabTransition: true,
        ),
      ),
    );
  }
}
