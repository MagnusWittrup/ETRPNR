import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:lions_den_app/screens/auth/components/widgets/CustomFormField.dart';
import 'package:lions_den_app/theme/colors.dart';
import 'widgets/CustomScrollableFormContainer.dart';

class SignUpFormStepThree extends StatefulWidget {
  const SignUpFormStepThree({
    this.pageController,
  });
  final PageController pageController;

  @override
  SignUpFormStepThreeState createState() {
    return SignUpFormStepThreeState();
  }
}

class SignUpFormStepThreeState extends State<SignUpFormStepThree> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _offeringController = TextEditingController();
  final TextEditingController _seekingController = TextEditingController();

  dynamic _onSubmit(String company) async {
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
            backgroundColor: Colors.green,
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const <Widget>[
                Text('Succes'),
                Icon(FlutterIcons.check_circle_fea),
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
                    _offeringController.value.text,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const <Widget>[
                      Text('Create user'),
                      SizedBox(width: 5),
                      Icon(FlutterIcons.user_plus_fea, size: 15),
                    ],
                  ),
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
          controller: _offeringController,
          labelText: "Offering sparring...",
          // suffixIcon: const Icon(FlutterIcons.briefcase_fea),
          validator: (value) {
            if (value.isEmpty) {
              return 'Please describe in what area you are offering sparring';
            }
            return null;
          },
        ),
        const SizedBox(
          height: 20,
        ),
        CustomFormField(
          node: _node,
          controller: _seekingController,
          labelText: "Seeking sparring...",
          // suffixIcon: const Icon(FlutterIcons.briefcase_fea),
          validator: (value) {
            if (value.isEmpty) {
              return 'Please describe in what area you are seeking sparring';
            }
            return null;
          },
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
