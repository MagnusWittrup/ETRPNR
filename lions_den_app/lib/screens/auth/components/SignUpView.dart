import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import './SignUpFormStepOne.dart';
import './SignUpFormStepThree.dart';
import './SignUpFormStepTwo.dart';

class SignUpView extends StatelessWidget {
  SignUpView();
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      return PageView(
        controller: _pageController,
        allowImplicitScrolling: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          SignUpFormStepOne(
            pageController: _pageController,
          ),
          SignUpFormStepTwo(
            pageController: _pageController,
          ),
          SignUpFormStepThree(
            pageController: _pageController,
          ),
        ],
      );
    });
  }
}
