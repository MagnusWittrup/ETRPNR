import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lions_den_app/dummy_data.dart';
import 'package:lions_den_app/logic/notifiers/active_user_notifier.dart';
import 'package:lions_den_app/screens/auth/components/widgets/CustomFormField.dart';
import 'package:lions_den_app/theme/colors.dart';
import 'widgets/CustomScrollableFormContainer.dart';

class SignUpFormStepTwo extends StatefulWidget {
  const SignUpFormStepTwo({
    this.pageController,
  });
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
    if (_formKey.currentState.validate()) {
      FocusScope.of(context).unfocus();

      context.read(activeUserProvider).update(DummyUser(
            dateOfBirth: DateTime.parse(dateOfBirth),
            fName: fName,
            lName: lName,
            gender: gender,
          ));

      widget.pageController.nextPage(
        curve: Curves.easeIn,
        duration: const Duration(milliseconds: 500),
      );
      return;
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
                Consumer(builder: (context, watch, widget) {
                  return ElevatedButton(
                    onPressed: () => _onSubmit(
                      _firstNameController.value.text,
                      _lastNameController.value.text,
                      _dateOfBirthController.value.text,
                      watch(activeUserProvider).user.gender,
                    ),
                    child: const Text('Next'),
                  );
                }),
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
              borderRadius: BorderRadius.circular(16.0),
              boxShadow: const [
                BoxShadow(
                  color: gunMetal,
                  offset: Offset(6, 6),
                )
              ],
              color: Colors.white),
          child: DateTimePicker(
            controller: _dateOfBirthController,
            onFieldSubmitted: (value) => debugPrint(value),
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
              borderRadius: BorderRadius.circular(16.0),
              boxShadow: const [
                BoxShadow(
                  color: gunMetal,
                  offset: Offset(6, 6),
                )
              ],
              color: Colors.white),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Gender'),
              Consumer(builder: (context, watch, widget) {
                return DropdownButton<String>(
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
                  value: watch(activeUserProvider).user.gender,
                  onChanged: (value) {
                    context
                        .read(activeUserProvider)
                        .update(DummyUser(gender: value));
                  },
                );
              })
            ],
          ),
        ),
      ],
    );
  }
}
