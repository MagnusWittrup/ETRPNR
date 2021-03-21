import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './SignUpFormStepOne.dart';
import './SignUpFormStepThree.dart';
import './SignUpFormStepTwo.dart';
import '../../../models/auth.dart';
import '../../../models/users.dart';

class SignUpView extends StatelessWidget {
  SignUpView(
    this.auth,
  );
  final AuthModel auth;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Consumer<UsersModel>(builder: (context, users, child) {
      return PageView(
        controller: _pageController,
        allowImplicitScrolling: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          SignUpFormStepOne(
            auth: auth,
            pageController: _pageController,
            users: users,
          ),
          SignUpFormStepTwo(
            auth: auth,
            pageController: _pageController,
            users: users,
          ),
          SignUpFormStepThree(
            auth: auth,
            pageController: _pageController,
            users: users,
          ),
        ],
      );
    });
  }
}
