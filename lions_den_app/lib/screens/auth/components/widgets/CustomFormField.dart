import 'package:flutter/material.dart';
import 'package:lions_den_app/theme/colors.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField({
    Key key,
    @required this.node,
    @required this.controller,
    @required this.labelText,
    this.errorText,
    this.obscureText,
    this.textInputAction,
    this.onEditingComplete,
    this.keyboardType,
    this.suffixIcon,
    this.validator,
  }) : super(key: key);

  final FocusScopeNode node;
  final TextEditingController controller;
  final String labelText;
  final String errorText;
  final bool obscureText;
  final TextInputAction textInputAction;
  final void Function() onEditingComplete;
  final TextInputType keyboardType;
  final Icon suffixIcon;
  final String Function(String) validator;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          // border: const Border.fromBorderSide(
          //   BorderSide(
          //     color: gunMetal,
          //     width: 3,
          //   ),
          // ),
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: gunMetal,
              offset: Offset(6, 6),
            )
          ],
          color: Colors.white
          // color: const Color(0xffABD6CF),
          ),
      padding: const EdgeInsets.fromLTRB(20, 5, 20, 15),
      child: TextFormField(
        textInputAction: textInputAction ?? TextInputAction.next,
        onEditingComplete: onEditingComplete ?? () => node.nextFocus(),
        obscureText: obscureText ?? false,
        keyboardType: keyboardType,
        controller: controller,
        // onChanged: (password) => _updatePass(password),
        decoration: InputDecoration(
          labelText: labelText,
          suffixIcon: suffixIcon,
          errorText: errorText,
          focusColor: gradientGreen,
        ),
        validator: validator ??
            (value) {
              if (value.isEmpty) {
                return 'Please enter a value.';
              }
              return null;
            },
      ),
    );
  }
}
