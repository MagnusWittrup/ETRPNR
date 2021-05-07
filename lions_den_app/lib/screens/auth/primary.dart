import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lions_den_app/screens/auth/components/LoginForm.dart';
import 'package:lions_den_app/screens/pages/swiper/components/BorderedGradientTetx.dart';
import 'package:lions_den_app/theme/colors.dart';
import 'components/SignUpView.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _showLoginOrSignup = 'login';
  void switchShowLoginOrSignup() {
    setState(() {
      _showLoginOrSignup == 'login'
          ? _showLoginOrSignup = 'signup'
          : _showLoginOrSignup = 'login';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      return Container(
        decoration: const BoxDecoration(
          gradient: gradientPrimary,
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Flexible(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          boxShadow: const [
                            BoxShadow(
                              color: gunMetal,
                              offset: Offset(6, 6),
                            )
                          ],
                          color: Colors.white),
                      child: Center(
                        child: GradientTextWithBorder(
                          text: _showLoginOrSignup == 'login'
                              ? 'Welcome to /APP NAME/'
                              : 'Sign up a new user',
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  _showLoginOrSignup == 'login'
                      ? const Flexible(
                          flex: 8,
                          child: LoginForm(),
                        )
                      : Flexible(
                          flex: 8,
                          child: SignUpView(),
                        ),
                  Flexible(
                    flex: 2,
                    child: _showLoginOrSignup == 'login'
                        ? ElevatedButton.icon(
                            onPressed: () => switchShowLoginOrSignup(),
                            icon: const Text('Sign up new user'),
                            label: const Icon(
                              FlutterIcons.user_plus_fea,
                              size: 20,
                            ),
                          )
                        : ElevatedButton.icon(
                            onPressed: () => switchShowLoginOrSignup(),
                            icon: const Icon(
                              FlutterIcons.arrow_left_fea,
                              size: 20,
                            ),
                            label: const Text('Return to login'),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
