import 'package:flutter/material.dart';

class FocusHandler extends StatelessWidget {
  final TextEditingController controller;
  const FocusHandler({@required this.child, @required this.controller});

  final Widget child;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
          controller.clear();
        }
      },
      child: child,
    );
  }
}
