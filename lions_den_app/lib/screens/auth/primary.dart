import 'package:flutter/material.dart';
import 'package:lions_den_app/screens/auth/components/LoginForm.dart';
import 'package:provider/provider.dart';
import '../../models/auth.dart';
import 'components/SignUpView.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _showLoginOrSignup = 'signup';
  void switchShowLoginOrSignup() {
    setState(() {
      _showLoginOrSignup == 'login'
          ? _showLoginOrSignup = 'signup'
          : _showLoginOrSignup = 'login';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthModel>(builder: (context, auth, child) {
      return Scaffold(
        // resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Flexible(
                  child: Center(
                    child: Text(
                      _showLoginOrSignup == 'login'
                          ? 'This is the login page'
                          : 'This is the signup page',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                _showLoginOrSignup == 'login'
                    ? Flexible(
                        flex: 8,
                        child: LoginForm(
                          auth,
                        ),
                      )
                    : Flexible(
                        flex: 8,
                        child: SignUpView(
                          auth,
                        ),
                      ),
                Flexible(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: () => switchShowLoginOrSignup(),
                    child: const Text('Switch'),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
