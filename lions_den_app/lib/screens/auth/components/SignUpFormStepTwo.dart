import 'package:firebase_auth/firebase_auth.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import '../../../models/auth.dart';

class SignUpFormStepTwo extends StatefulWidget {
  SignUpFormStepTwo(
    this.auth,
    this._pageController,
  );
  final AuthModel auth;
  final PageController _pageController;

  @override
  SignUpFormStepTwoState createState() {
    return SignUpFormStepTwoState();
  }
}

class SignUpFormStepTwoState extends State<SignUpFormStepTwo> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController =
      new TextEditingController();
  final TextEditingController _lastNameController = new TextEditingController();

  dynamic _onSubmit(String email, String password) async {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState.validate()) {
      dynamic result = await widget.auth.registerUser(
        userEmail: email,
        userPassword: password,
      );

      debugPrint('Result - Value: ' +
          result.toString() +
          '\nResult -Type: ' +
          result.runtimeType.toString());

      if (result.runtimeType.toString() == 'FirebaseAuthException') {
        // errorHandling(result);
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(seconds: 1, milliseconds: 500),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('Processing Data..'),
              CircularProgressIndicator(),
            ],
          ),
        ),
      );

      Future.delayed(Duration(seconds: 2), () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Succes'),
                Icon(FlutterIcons.check_circle_fea),
              ],
            ),
          ),
        );
        Future.delayed(Duration(milliseconds: 500), () {
          Navigator.pushReplacementNamed(context, '/forum');
        });
      });
    }
  }

  String _gender;

  @override
  Widget build(BuildContext context) {
    FocusScopeNode _node = FocusScope.of(context);
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Flexible(
          child: ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(20, 5, 20, 15),
                decoration: BoxDecoration(
                  color: Theme.of(context).focusColor,
                  borderRadius: BorderRadius.circular(10),
                ),

                // dropdown below..
                child:
                    //? FIRST NAME FORM ?//
                    TextFormField(
                  textInputAction: TextInputAction.next,
                  onEditingComplete: () => _node.nextFocus(),
                  controller: _firstNameController,
                  initialValue: null,
                  decoration: InputDecoration(
                    labelText: "First name",
                    suffixIcon: Icon(FlutterIcons.user_fea),
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter a first name.';
                    }
                    return null;
                  },
                ),
                //! FIRST NAME FORM !//
              ),
              Container(
                padding: EdgeInsets.fromLTRB(20, 5, 20, 15),
                decoration: BoxDecoration(
                  color: Theme.of(context).focusColor,
                  borderRadius: BorderRadius.circular(10),
                ),

                // dropdown below..
                child:
                    //? LAST NAME FORM ?//
                    TextFormField(
                  textInputAction: TextInputAction.next,
                  onEditingComplete: () => _node.nextFocus(),
                  controller: _lastNameController,
                  initialValue: null,
                  decoration: InputDecoration(
                    labelText: "Last name",
                    suffixIcon: Icon(FlutterIcons.user_fea),
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter a last name.';
                    }
                    return null;
                  },
                ),
                //! LAST NAME FORM !//
              ),
              Container(
                padding: EdgeInsets.fromLTRB(20, 5, 20, 15),
                decoration: BoxDecoration(
                  color: Theme.of(context).focusColor,
                  borderRadius: BorderRadius.circular(10),
                ),

                // dropdown below..
                child: DateTimePicker(
                  initialValue: '',
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2100),
                  dateLabelText: 'Date of Birth',
                  icon: Icon(FlutterIcons.calendar_fea),
                  onChanged: (val) => print(val),
                  validator: (val) {
                    if (val.isEmpty) {
                      return 'Please input your date of birth.';
                    }
                    return null;
                  },
                  onSaved: (val) => print(val),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(20, 5, 20, 15),
                decoration: BoxDecoration(
                  color: Theme.of(context).focusColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Gender'),
                    DropdownButton<String>(
                      hint: Text('Choose a gender'),
                      items: <String>[
                        'Male',
                        'Female',
                        'Other',
                        'Prefer not to disclose'
                      ].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      value: _gender,
                      onChanged: (value) {
                        print(value);
                        setState(() {
                          _gender = value;
                        });
                      },
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () => widget._pageController.previousPage(
                      curve: Curves.easeIn,
                      duration: Duration(milliseconds: 500),
                    ),
                    child: Text('Return'),
                  ),
                  ElevatedButton(
                    onPressed: () => _onSubmit(
                      _firstNameController.value.text,
                      _lastNameController.value.text,
                    ),
                    child: Text('Next'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

// void errorHandling(FirebaseAuthException error) {
  //   String errorMessage;
  //   String errorSource;

  //   switch (error.code) {
  //     //   errorMessage = 'Invalid password or email.';
  //     //   errorSource = 'email';
  //     //   break;
  //     case 'weak-password':
  //       errorMessage = 'Password too weak.';
  //       errorSource = 'pass';
  //       break;
  //     case 'email-already-in-use':
  //     case 'invalid-email':
  //       errorMessage = 'Invalid email.';
  //       errorSource = 'email';
  //       break;
  //     default:
  //       break;
  //   }
  //   setErrorText(errorMessage, errorSource);
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Text(errorMessage),
  //     ),
  //   );
  //   return;
  // }

  // void setErrorText(String errorText, String emailOrPass) {
  //   setState(() {
  //     switch (emailOrPass) {
  //       case 'email':
  //         _emailErrorText = errorText;
  //         break;
  //       case 'pass':
  //         _passErrorText = errorText;
  //         break;
  //       case 'both':
  //         _emailErrorText = errorText;
  //         _passErrorText = errorText;
  //         break;
  //       default:
  //         break;
  //     }
  //   });
  // }
  
  
  // bool validateEmail(String email) {
  //   return RegExp(
  //     r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
  //   ).hasMatch(email);
  // }



