import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lions_den_app/dummy_data.dart';
import 'package:lions_den_app/logic/notifiers/active_user_notifier.dart';
import 'package:lions_den_app/screens/auth/components/widgets/CustomScrollableFormContainer.dart';

import './widgets/CustomFormField.dart';

class SignUpFormStepOne extends StatefulWidget {
  const SignUpFormStepOne({
    this.pageController,
  });
  final PageController pageController;

  @override
  SignUpFormStepOneState createState() {
    return SignUpFormStepOneState();
  }
}

class SignUpFormStepOneState extends State<SignUpFormStepOne> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordControllerOne = TextEditingController();
  final TextEditingController _passwordControllerTwo = TextEditingController();

  String _emailErrorText;
  String _passErrorText;

  bool validateEmail(String email) {
    return RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    ).hasMatch(email);
  }

  dynamic _onSubmit() async {
    FocusScope.of(context).unfocus();

    if (_formKey.currentState.validate()) {
      context.read(activeUserProvider).update(DummyUser(
            email: _emailController.text,
            password: _passwordControllerOne.text,
          ));

      widget.pageController.nextPage(
        curve: Curves.bounceIn,
        duration: const Duration(milliseconds: 2),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final FocusScopeNode _node = FocusScope.of(context);

    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomScrollableFormContainer(
              children: <Widget>[
                formFields(_node),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () => _onSubmit(),
                  child: const Text('Next'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Column formFields(FocusScopeNode _node) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        // ? EMAIL FORM ? //
        CustomFormField(
          node: _node,
          keyboardType: TextInputType.emailAddress,
          controller: _emailController,
          labelText: "E-mail",
          suffixIcon: const Icon(FlutterIcons.mail_fea),
          errorText: _emailErrorText,
          validator: (value) {
            if (value.isEmpty) {
              return 'Please enter an email.';
            }

            if (!validateEmail(_emailController.text)) {
              return 'E-mail is not valid.';
            }
            return null;
          },
        ),

        const SizedBox(
          height: 10,
        ),

        //? PASSWORD FORM - 1 ?//
        CustomFormField(
          node: _node,
          controller: _passwordControllerOne,
          errorText: _passErrorText,
          labelText: 'Password',
          keyboardType: TextInputType.visiblePassword,
          obscureText: true,
          suffixIcon: const Icon(FlutterIcons.lock_fea),
          validator: (value) {
            if (value.isEmpty) {
              return 'Please re-enter password.';
            }
            if (value.length < 6) {
              return 'Password must be at least 6 characters long.';
            }
            return null;
          },
        ),

        const SizedBox(
          height: 10,
        ),

        //? PASSWORD FORM - 2 ?//
        CustomFormField(
          node: _node,
          errorText: _passErrorText,
          keyboardType: TextInputType.visiblePassword,
          obscureText: true,
          suffixIcon: const Icon(FlutterIcons.lock_fea),
          textInputAction: TextInputAction.done,
          onEditingComplete: () => _onSubmit(),
          controller: _passwordControllerTwo,
          labelText: "Re-enter password",
          validator: (value) {
            if (value.isEmpty) {
              return 'Please re-enter password.';
            }

            if (value != _passwordControllerOne.value.text) {
              return "Password doesn't match";
            }
            if (value.length < 6) {
              return 'Password must be at least 6 characters long.';
            }
            return null;
          },
        ),
      ],
    );
  }
}
