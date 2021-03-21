import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lions_den_app/models/users.dart';
import 'package:lions_den_app/screens/landing/primary.dart';
import 'package:provider/provider.dart';

import 'components/Loading.dart';
import 'components/SomethingWentWrong.dart';
import 'models/auth.dart';
import 'screens/auth/primary.dart';
import 'screens/forum/primary.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return const SomethingWentWrong();
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return LionsDenApp();
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return const Loading();
      },
    );
  }
}

class LionsDenApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthModel>(create: (_) => AuthModel()),
        ChangeNotifierProvider<UsersModel>(create: (_) => UsersModel()),
        // Provider<SomethingElse>(create: (_) => SomethingElse()),
        // Provider<AnotherThing>(create: (_) => AnotherThing()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/login': (ctx) => const LoginScreen(),
          '/forum': (ctx) => const ForumScreen(),
          '/': (ctx) => const LandingScreen(),
        },
      ),
    );
  }
}
