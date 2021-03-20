import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../../models/auth.dart';

class LandingScreen extends StatefulWidget {
  LandingScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LandingScreen> {
  void initState() {
    super.initState();
    determineUserSignedIn();
  }

  // void dispose() {
  //   super.dispose();
  // }
  bool _loadingComplete = false;

  void determineUserSignedIn() {
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _loadingComplete = true;
      });
      Future.delayed(Duration(milliseconds: 500), () {
        FirebaseAuth.instance.authStateChanges().listen((User user) {
          if (user != null) {
            print('User is signed in!');
            Navigator.of(context).pushReplacementNamed('/forum');
          } else {
            print('User is not signed in!');
            setState(() {});
            Navigator.of(context).pushReplacementNamed('/login');
          }
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthModel>(builder: (context, auth, child) {
      return Scaffold(
        body: Center(
          child: _loadingComplete
              ? Icon(
                  FlutterIcons.check_circle_fea,
                  size: 60,
                  color: Theme.of(context).primaryColor,
                )
              : SizedBox(
                  height: 50,
                  width: 50,
                  child: CircularProgressIndicator(),
                ),
        ),
      );
    });
  }
}
