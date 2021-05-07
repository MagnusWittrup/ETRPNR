import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:lions_den_app/theme/colors.dart';
import './widgets/CustomFormField.dart';

class LoginForm extends StatefulWidget {
  const LoginForm();
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 1, milliseconds: 500),
          backgroundColor: gradientGreen,
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
          Navigator.pushReplacementNamed(context, '/main');
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
          const SizedBox(
            height: 20,
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
          const SizedBox(
            height: 20,
          ),
          ElevatedButton.icon(
            onPressed: () => _onSubmit(
              _emailController.value.text,
              _passwordController.value.text,
            ),
            icon: Text('Sign in'),
            label: Icon(
              FlutterIcons.log_in_fea,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}
