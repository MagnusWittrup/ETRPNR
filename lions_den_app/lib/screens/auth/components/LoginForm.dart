import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import '../../../models/auth.dart';
import './widgets/CustomFormField.dart';

class LoginForm extends StatefulWidget {
  const LoginForm(
    this.auth,
  );
  final AuthModel auth;

  @override
  SignUpFormState createState() {
    return SignUpFormState();
  }
}

class SignUpFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _emailErrorText;
  String _passErrorText;

  void errorHandling(FirebaseAuthException error) {
    String errorMessage;
    String errorSource;

    switch (error.code) {
      case 'wrong-password':
      case 'user-not-found':
        errorMessage = 'Wrong password or email.';
        errorSource = 'both';
        break;
      case 'user-disabled':
        errorMessage = 'The user is disabled.';
        errorSource = 'email';
        break;
      case 'invalid-email':
        errorMessage = 'Not a valid e-mail.';
        errorSource = 'email';
        break;
      default:
        break;
    }
    setErrorText(errorMessage, errorSource);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(errorMessage),
      ),
    );
    return;
  }

  void setErrorText(String errorText, String emailOrPass) {
    setState(() {
      switch (emailOrPass) {
        case 'email':
          _emailErrorText = errorText;
          break;
        case 'pass':
          _passErrorText = errorText;
          break;
        case 'both':
          _emailErrorText = errorText;
          _passErrorText = errorText;
          break;
        default:
          break;
      }
    });
  }

  bool validateEmail(String email) {
    return RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    ).hasMatch(email);
  }

  dynamic _onSubmit(String email, String password) async {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState.validate()) {
      final dynamic result = await widget.auth.loginUser(
        userEmail: email,
        userPassword: password,
      );

      debugPrint(
          'Result - Value: $result\nResult -Type: ${result.runtimeType}');

      if (result.runtimeType.toString() == 'FirebaseAuthException') {
        errorHandling(result as FirebaseAuthException);
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 1, milliseconds: 500),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const <Widget>[
              Text('Processing Data..'),
              CircularProgressIndicator(),
            ],
          ),
        ),
      );

      Future.delayed(const Duration(seconds: 2), () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 2, milliseconds: 500),
            backgroundColor: Colors.green,
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const <Widget>[
                Text('Succes'),
                Icon(
                  FlutterIcons.check_circle_fea,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        );
        Future.delayed(const Duration(milliseconds: 500), () {
          Navigator.pushReplacementNamed(context, '/forum');
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final FocusScopeNode _node = FocusScope.of(context);

    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CustomFormField(
            node: _node,
            controller: _emailController,
            labelText: 'E-mail',
            keyboardType: TextInputType.emailAddress,
            suffixIcon: const Icon(FlutterIcons.mail_fea),
            errorText: _emailErrorText,
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter an email';
              }
              return null;
            },
          ),
          CustomFormField(
            node: _node,
            controller: _passwordController,
            labelText: 'Password',
            obscureText: true,
            keyboardType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.done,
            onEditingComplete: () => _onSubmit(
              _emailController.value.text,
              _passwordController.value.text,
            ),
            suffixIcon: const Icon(FlutterIcons.lock_fea),
            errorText: _passErrorText,
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter a password';
              }
              return null;
            },
          ),
          ElevatedButton(
            onPressed: () => _onSubmit(
              _emailController.value.text,
              _passwordController.value.text,
            ),
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}
