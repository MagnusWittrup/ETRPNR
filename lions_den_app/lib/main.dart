import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lions_den_app/logic/notifiers/accepted_users_notifer.dart';

import 'components/Loading.dart';
import 'components/SomethingWentWrong.dart';
import 'screens/auth/primary.dart';
import 'screens/main_screen.dart';
import 'screens/pages/messages/primary_message.dart';

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
    return ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/login': (ctx) => const LoginScreen(),
          '/main': (ctx) => MainScreen(),
          // '/': (ctx) => const LandingScreen(),
          //
          '/message': (context) => MessageScreen(),
        },
        initialRoute: '/main',
      ),
    );
  }
}
