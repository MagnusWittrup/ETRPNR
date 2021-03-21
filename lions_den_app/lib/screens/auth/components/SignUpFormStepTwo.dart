import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:lions_den_app/screens/auth/components/widgets/CustomFormField.dart';
import '../../../models/auth.dart';
import '../../../models/users.dart';
import 'widgets/CustomScrollableFormContainer.dart';

class SignUpFormStepTwo extends StatefulWidget {
  const SignUpFormStepTwo({
    this.auth,
    this.users,
    this.pageController,
  });
  final AuthModel auth;
  final UsersModel users;
  final PageController pageController;

  @override
  SignUpFormStepTwoState createState() {
    return SignUpFormStepTwoState();
  }
}

class SignUpFormStepTwoState extends State<SignUpFormStepTwo> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();

  dynamic _onSubmit(
    String fName,
    String lName,
    String dateOfBirth,
    String gender,
  ) async {
    FocusScope.of(context).unfocus();
    widget.users.dateOfBirth = DateTime.parse(dateOfBirth);
    widget.users.firstName = fName;
    widget.users.lastName = lName;
    widget.users.gender = gender;
    debugPrint(
      'First name: ${widget.users.firstName} \nLast name: ${widget.users.lastName} \nDate of Birth: ${widget.users.dateOfBirth}\nGender: ${widget.users.gender}',
    );
    widget.pageController.nextPage(
      curve: Curves.easeIn,
      duration: const Duration(milliseconds: 500),
    );
    return;
  }

  String _gender;

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
                formFields(_node, context),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () => widget.pageController.previousPage(
                    curve: Curves.easeIn,
                    duration: const Duration(milliseconds: 500),
                  ),
                  child: const Text('Return'),
                ),
                ElevatedButton(
                  onPressed: () => _onSubmit(
                    _firstNameController.value.text,
                    _lastNameController.value.text,
                    _dateOfBirthController.value.text,
                    _gender,
                  ),
                  child: const Text('Next'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Column formFields(
    FocusScopeNode _node,
    BuildContext context,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        CustomFormField(
          node: _node,
          controller: _firstNameController,
          labelText: "First name",
          suffixIcon: const Icon(FlutterIcons.user_fea),
          validator: (value) {
            if (value.isEmpty) {
              return 'Please enter a first name.';
            }
            return null;
          },
        ),
        const SizedBox(
          height: 10,
        ),
        CustomFormField(
          node: _node,
          controller: _lastNameController,
          labelText: "Last name",
          suffixIcon: const Icon(FlutterIcons.user_fea),
          validator: (value) {
            if (value.isEmpty) {
              return 'Please enter a last name.';
            }
            return null;
          },
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(20, 5, 20, 15),
          decoration: BoxDecoration(
            color: Theme.of(context).focusColor,
            borderRadius: BorderRadius.circular(10),
          ),

          // dropdown below..
          child: DateTimePicker(
            controller: _dateOfBirthController,
            onFieldSubmitted: (value) => debugPrint(widget.users.company),
            autofocus: true,
            firstDate: DateTime(1900),
            lastDate: DateTime(2100),
            dateLabelText: 'Date of Birth',
            icon: const Icon(FlutterIcons.calendar_fea),
            validator: (val) {
              if (val.isEmpty) {
                return 'Please input your date of birth.';
              }
              return null;
            },
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(20, 5, 20, 15),
          decoration: BoxDecoration(
            color: Theme.of(context).focusColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Gender'),
              DropdownButton<String>(
                hint: const Text('Choose a gender'),
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
                  debugPrint(value);
                  _gender = value;
                },
              )
            ],
          ),
        ),
      ],
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
