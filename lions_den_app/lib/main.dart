import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lions_den_app/theme/colors.dart';

import 'screens/auth/primary.dart';
import 'screens/main_screen.dart';
import 'screens/pages/messages/primary_message.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(LionsDenApp());
}

class LionsDenApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: createMaterialColor(gunMetal),
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: '/login',
        routes: {
          '/login': (ctx) => const LoginScreen(),
          '/main': (ctx) => MainScreen(),
          // '/': (ctx) => const LandingScreen(),
          '/message': (context) => MessageScreen(),
        },
        // initialRoute: '/main',
      ),
    );
  }
}

MaterialColor createMaterialColor(Color color) {
  List strengths = <num>[.05];
  Map swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  strengths.forEach((strength) {
    final double ds = 0.5 - (strength as num);
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  });
  return MaterialColor(color.value, swatch as Map<int, Color>);
}
