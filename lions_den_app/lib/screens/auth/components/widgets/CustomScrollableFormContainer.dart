import 'package:flutter/material.dart';

class CustomScrollableFormContainer extends StatelessWidget {
  const CustomScrollableFormContainer({Key key, this.children})
      : super(key: key);
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: children,
            ),
          ),
        ],
      ),
    );
  }
}
