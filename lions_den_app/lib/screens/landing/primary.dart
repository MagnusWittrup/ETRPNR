import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LandingScreen> {
  @override
  void initState() {
    super.initState();
    determineUserSignedIn();
  }

  bool _loadingComplete = false;

  void determineUserSignedIn() {
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _loadingComplete = true;
      });
      Future.delayed(const Duration(milliseconds: 500), () {
        FirebaseAuth.instance.authStateChanges().listen((User user) {
          if (user != null) {
            debugPrint('User is signed in!');
            Navigator.of(context).pushReplacementNamed('/swiper');
          } else {
            debugPrint('User is not signed in!');
            setState(() {});
            Navigator.of(context).pushReplacementNamed('/login');
          }
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _loadingComplete
            ? Icon(
                FlutterIcons.check_circle_fea,
                size: 60,
                color: Theme.of(context).primaryColor,
              )
            : const SizedBox(
                height: 50,
                width: 50,
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
