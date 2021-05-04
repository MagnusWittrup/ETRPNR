import 'package:flutter/material.dart';
import 'package:lions_den_app/theme/colors.dart';

import 'components/focusHandler.dart';
import 'components/messageListView.dart';
import 'components/searchField.dart';

class MessagesPage extends StatelessWidget {
  const MessagesPage();

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    return Container(
      decoration: const BoxDecoration(
        gradient: gradientPrimary,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: FocusHandler(
          controller: controller,
          child: Column(
            children: [
              SearchField(
                controller: controller,
              ),
              MessagesListWiew(),
            ],
          ),
        ),
      ),
    );
  }
}
