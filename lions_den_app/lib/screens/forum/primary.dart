import 'package:flutter/material.dart';
import 'package:lions_den_app/models/auth.dart';
import 'package:provider/provider.dart';

class ForumScreen extends StatelessWidget {
  const ForumScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton(
            onPressed: () {
              context.read<AuthModel>().logout();
              Navigator.pushReplacementNamed(context, '/login');
            },
            child: const Text('Sign out'),
          ),
          const Text(
            "This is the forum page",
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
