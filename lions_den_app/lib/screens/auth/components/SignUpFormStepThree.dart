import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:lions_den_app/screens/auth/components/widgets/CustomFormField.dart';
import '../../../models/auth.dart';
import '../../../models/users.dart';
import 'widgets/CustomScrollableFormContainer.dart';

class SignUpFormStepThree extends StatefulWidget {
  const SignUpFormStepThree({
    this.auth,
    this.users,
    this.pageController,
  });
  final AuthModel auth;
  final UsersModel users;
  final PageController pageController;

  @override
  SignUpFormStepThreeoState createState() {
    return SignUpFormStepThreeoState();
  }
}

class SignUpFormStepThreeoState extends State<SignUpFormStepThree> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  dynamic _onSubmit(String company) async {
    FocusScope.of(context).unfocus();
    if (widget.users.activeTags.isEmpty) {
      widget.users.updateValue(
          variable: "tagError", value: "Please select at least one tag.");
    } else {
      widget.users.updateValue(variable: "tagError", value: '');
    }
    if (_formKey.currentState.validate() &&
        widget.users.activeTags.isNotEmpty) {
      widget.users.company = company;
      await widget.users.addUser();

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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomScrollableFormContainer(
              children: <Widget>[
                formFields(_node, context, widget.users),
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
                    _companyController.value.text,
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
      FocusScopeNode _node, BuildContext context, UsersModel users) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        CustomFormField(
          node: _node,
          controller: _companyController,
          labelText: "Company/Occupation",
          suffixIcon: const Icon(FlutterIcons.briefcase_fea),
          validator: (value) {
            if (value.isEmpty) {
              return 'Please enter a company or occupation.';
            }
            return null;
          },
        ),
        const SizedBox(
          height: 10,
        ),
        TagList(users: users),
      ],
    );
  }
}

class TagList extends StatelessWidget {
  const TagList({
    Key key,
    @required this.users,
  }) : super(key: key);
  final UsersModel users;

  // List<Widget> _renderTags() {
  //   List<Widget> tagList = List.generate(
  //     users.tags.length,
  //     (index) => TagElement(
  //       tagName: users.tags[index],
  //       users: users,
  //     ),
  //   );
  //   tagList.add(
  //     ElevatedButton.icon(
  //       onPressed: () {},
  //       icon: const Icon(
  //         FlutterIcons.plus_fea,
  //       ),
  //       label: const Text("Add tag"),
  //     ),
  //   );

  //   return tagList;
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 5, 20, 15),
      decoration: BoxDecoration(
        color: Theme.of(context).focusColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Expertise: ',
            style: TextStyle(
              color: users.tagError != '' ? Theme.of(context).errorColor : null,
            ),
          ),
          Wrap(
            spacing: 8,
            runAlignment: WrapAlignment.spaceBetween,
            alignment: WrapAlignment.spaceEvenly,
            children: List.generate(
              users.tags.length,
              (index) => TagElement(
                tagName: users.tags[index],
                users: users,
              ),
            ),
          ),
          users.tagError != ''
              ? Text(
                  users.tagError,
                  style: TextStyle(
                    color: Theme.of(context).errorColor,
                  ),
                )
              : Container(),

          // fixme: determine if this functionality is necessary
          // ElevatedButton.icon(
          //   onPressed: () {},
          //   icon: const Icon(
          //     FlutterIcons.plus_fea,
          //   ),
          //   label: const Text("Add tag"),
          // ),
        ],
      ),
    );
  }
}

class TagElement extends StatelessWidget {
  const TagElement({
    Key key,
    @required this.tagName,
    @required this.users,
  }) : super(key: key);
  final String tagName;
  final UsersModel users;

  void _onPress(String tag) {
    debugPrint('Tag: $tag');
    final List<String> tempTagList = users.activeTags;
    if (!tempTagList.contains(tag)) {
      tempTagList.add(tag);
    } else {
      tempTagList.remove(tag);
    }
    users.updateValue(
      variable: 'activeTags',
      value: tempTagList,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: users.activeTags.contains(tagName)
            ? Theme.of(context).primaryColor
            : Theme.of(context).focusColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100000),
        ),
        // BorderRadius.circular(10),
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
      ),
      onPressed: () => _onPress(tagName),
      child: Text(tagName),
    );
  }
}
