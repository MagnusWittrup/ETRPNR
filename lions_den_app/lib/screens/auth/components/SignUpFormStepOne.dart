import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_password_strength/flutter_password_strength.dart';
import '../../../models/auth.dart';

class SignUpFormStepOne extends StatefulWidget {
  SignUpFormStepOne(
    this.auth,
    this._pageController,
  );
  final AuthModel auth;
  final PageController _pageController;

  @override
  SignUpFormStepOneState createState() {
    return SignUpFormStepOneState();
  }
}

class SignUpFormStepOneState extends State<SignUpFormStepOne> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _passwordControllerOne =
      new TextEditingController();
  final TextEditingController _passwordControllerTwo =
      new TextEditingController();

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
    widget._pageController.nextPage(
      curve: Curves.easeIn,
      duration: Duration(milliseconds: 500),
    );

    // if (_formKey.currentState.validate()) {
    //   dynamic result = await widget.auth.registerUser(
    //     userEmail: _emailController.value.text,
    //     userPassword: _passwordControllerOne.value.text,
    //   );

    //   debugPrint('Result - Value: ' +
    //       result.toString() +
    //       '\nResult -Type: ' +
    //       result.runtimeType.toString());

    //   if (result.runtimeType.toString() == 'FirebaseAuthException') {
    //     errorHandling(result);
    //     return;
    //   }

    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //       duration: Duration(seconds: 1, milliseconds: 500),
    //       content: Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //         children: <Widget>[
    //           Text('Processing Data..'),
    //           CircularProgressIndicator(),
    //         ],
    //       ),
    //     ),
    //   );

    //   Future.delayed(Duration(seconds: 2), () {
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       SnackBar(
    //         duration: Duration(seconds: 2, milliseconds: 500),
    //         backgroundColor: Colors.green,
    //         content: Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: <Widget>[
    //             Text('Succes'),
    //             Icon(
    //               FlutterIcons.check_circle_fea,
    //               color: Colors.white,
    //             ),
    //           ],
    //         ),
    //       ),
    //     );
    //     Future.delayed(Duration(milliseconds: 500), () {
    //       widget._pageController.nextPage(
    //         curve: Curves.bounceIn,
    //         duration: Duration(milliseconds: 2),
    //       );
    //     });
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    FocusScopeNode _node = FocusScope.of(context);
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(20, 5, 20, 15),
              decoration: BoxDecoration(
                color: Theme.of(context).focusColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child:
                  //? EMAIL FORM ?//
                  TextFormField(
                textInputAction: TextInputAction.next,
                onEditingComplete: () => _node.nextFocus(),
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                initialValue: null,
                decoration: InputDecoration(
                  labelText: "E-mail",
                  suffixIcon: Icon(FlutterIcons.mail_fea),
                  errorText: _emailErrorText,
                ),
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
              //! EMAIL FORM !//
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 5, 20, 15),
              decoration: BoxDecoration(
                color: Theme.of(context).focusColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child:
                  //? PASSWORD FORM - 1 ?//
                  TextFormField(
                textInputAction: TextInputAction.next,
                onEditingComplete: () => _node.nextFocus(),
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                controller: _passwordControllerOne,
                initialValue: null,
                // onChanged: (password) => _updatePass(password),
                decoration: InputDecoration(
                  labelText: "Password",
                  suffixIcon: Icon(FlutterIcons.lock_fea),
                  errorText: _passErrorText,
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter a password.';
                  }

                  if (value.length < 6) {
                    return 'Password must be at least 6 characters long.';
                  }
                  return null;
                },
              ),
              //! PASSWORD FORM - 1 !//
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
            Container(
              padding: EdgeInsets.fromLTRB(20, 5, 20, 15),
              decoration: BoxDecoration(
                color: Theme.of(context).focusColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child:
                  //? PASSWORD FORM - 2 ?//
                  TextFormField(
                textInputAction: TextInputAction.done,
                onEditingComplete: () => _onSubmit(),
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                controller: _passwordControllerTwo,
                initialValue: null,
                decoration: InputDecoration(
                  labelText: "Re-enter password",
                  suffixIcon: Icon(FlutterIcons.lock_fea),
                  errorText: _passErrorText,
                ),
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
              //! PASSWORD FORM - 2 !//
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () => _onSubmit(),
                  child: Text('Next'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
