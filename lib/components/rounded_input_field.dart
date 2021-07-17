import 'package:buthings/components/textfield_container.dart';
import 'package:buthings/constants.dart';
import 'package:flutter/material.dart';

class RoundedInputField extends StatelessWidget {
  final String? hintText;
  final String? Function(String?)? validator;
  final IconData? icon;
  final TextEditingController? controller;
  final int? maxlines;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  const RoundedInputField({
    Key? key,
    this.hintText,
    this.icon,
    this.controller,
    this.validator,
    this.maxlines,
    this.keyboardType,
    this.textInputAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        textInputAction: textInputAction,
        keyboardType: keyboardType,
        maxLines: maxlines,
        validator: validator,
        controller: controller,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: kPrimaryColor,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
