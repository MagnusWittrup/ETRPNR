import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:lions_den_app/screens/auth/components/widgets/CustomScrollableFormContainer.dart';
import '../../../models/auth.dart';
import '../../../models/users.dart';
import './widgets/CustomFormField.dart';

class SignUpFormStepOne extends StatefulWidget {
  const SignUpFormStepOne({
    this.auth,
    this.users,
    this.pageController,
  });
  final AuthModel auth;
  final UsersModel users;
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

  void errorHandling(FirebaseAuthException error) {
    String errorMessage;
    String errorSource;

    switch (error.code) {
      case 'weak-password':
        errorMessage = 'Password too weak.';
        errorSource = 'pass';
        break;
      case 'email-already-in-use':
      case 'invalid-email':
        errorMessage = 'Invalid email.';
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

  dynamic _onSubmit() async {
    FocusScope.of(context).unfocus();

    // return;

    if (_formKey.currentState.validate()) {
      final dynamic result = await widget.auth.registerUser(
        userEmail: _emailController.value.text,
        userPassword: _passwordControllerOne.value.text,
      );

      debugPrint(
          'Result - Value: $result\n Result -Type: ${result.runtimeType}');

      if (result.runtimeType.toString() == 'FirebaseAuthException') {
        errorHandling(result as FirebaseAuthException);
        return;
      }
      debugPrint('${result.user.uid}');

      widget.users.updateValue(
        variable: 'uid',
        value: result.user.uid,
      );

      widget.pageController.nextPage(
        curve: Curves.bounceIn,
        duration: const Duration(milliseconds: 2),
      );

      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     duration: const Duration(seconds: 1, milliseconds: 500),
      //     content: Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //       children: const <Widget>[
      //         Text('Processing Data..'),
      //         CircularProgressIndicator(),
      //       ],
      //     ),
      //   ),
      // );

      // Future.delayed(const Duration(seconds: 2), () {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(
      //       duration: const Duration(seconds: 2, milliseconds: 500),
      //       backgroundColor: Colors.green,
      //       content: Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //         children: const <Widget>[
      //           Text('Succes'),
      //           Icon(
      //             FlutterIcons.check_circle_fea,
      //             color: Colors.white,
      //           ),
      //         ],
      //       ),
      //     ),
      //   );
      //   Future.delayed(const Duration(milliseconds: 500), () {
      //     widget.pageController.nextPage(
      //       curve: Curves.bounceIn,
      //       duration: const Duration(milliseconds: 2),
      //     );
      //   });
      // });
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

        // SizedBox(height: 5),
        // Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     Text(
        //       'Password strength:',
        //       textAlign: TextAlign.left,
        //     ),
        //     FlutterPasswordStrength(
        //       strengthCallback: (strength) => _updateStrength(strength),
        //       password: _passwordControllerOne.value.text,
        //     ),
        //   ],
        // ),

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
