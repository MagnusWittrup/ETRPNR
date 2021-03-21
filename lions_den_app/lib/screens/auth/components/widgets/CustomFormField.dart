import 'package:flutter/material.dart';

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
      padding: const EdgeInsets.fromLTRB(20, 5, 20, 15),
      decoration: BoxDecoration(
        color: Theme.of(context).focusColor,
        borderRadius: BorderRadius.circular(10),
      ),
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
