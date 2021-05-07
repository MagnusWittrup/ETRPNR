import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:lions_den_app/theme/colors.dart';

class SearchField extends StatelessWidget {
  final TextEditingController controller;
  const SearchField({@required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: "Search...",
          hintStyle: TextStyle(
            color: slateGray,
          ),
          prefixIcon: Icon(
            Icons.search,
            color: slateGray,
            size: 20,
          ),
          suffixIcon: controller.text.isEmpty
              ? IconButton(
                  icon: Icon(
                    FlutterIcons.x_circle_fea,
                    color: slateGray,
                    size: 20,
                  ),
                  onPressed: () {
                    FocusScopeNode currentFocus = FocusScope.of(context);

                    if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                      controller.clear();
                      // context.read(acceptedDummyUserListProvider.notifier).reset();
                    }
                  })
              : null,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.grey.shade100)),
          filled: true,
          fillColor: Colors.grey.shade100,
          contentPadding: EdgeInsets.all(8),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.grey.shade100)),
        ),
        onChanged: (String searchInput) {
          // context.read(acceptedDummyUserListProvider.notifier).filter(searchInput);
        },
      ),
    );
  }
}
