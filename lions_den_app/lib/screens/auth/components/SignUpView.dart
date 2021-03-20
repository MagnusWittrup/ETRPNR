import 'package:flutter/material.dart';
import 'package:lions_den_app/screens/auth/components/SignUpFormStepOne.dart';
import 'package:lions_den_app/screens/auth/components/SignUpFormStepTwo.dart';
import 'package:provider/provider.dart';
import '../../../models/auth.dart';
import '../../../models/users.dart';

class SignUpView extends StatelessWidget {
  SignUpView(
    this.auth,
  );
  final AuthModel auth;
  final PageController _pageController = new PageController();

  @override
  Widget build(BuildContext context) {
    return Consumer<UsersModel>(builder: (context, users, child) {
      return PageView(
        controller: _pageController,
        allowImplicitScrolling: true,
        physics: NeverScrollableScrollPhysics(),
        children: [
          SignUpFormStepOne(auth, _pageController),
          SignUpFormStepTwo(auth, _pageController),
          Container(
            color: Colors.green,
          ),
          Container(
            color: Colors.blue,
          ),
        ],
      );
    });
  }
}
