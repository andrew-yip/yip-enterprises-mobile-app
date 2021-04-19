
import 'package:ecommerce_project/constants.dart';
import 'package:flutter/material.dart';

// input for email, password, and search

class CustomInput extends StatelessWidget {
  final String hintText;
  final Function(String) onChanged; // input is a string
  final Function(String) onSubmitted; // input is a string
  final FocusNode focusNode;
  final TextInputAction textInputAction;
  final bool isPasswordField;
  final bool hasMicrophone;
  CustomInput({this.hintText, this.onChanged, this.onSubmitted, this.focusNode, this.textInputAction, this.isPasswordField, this.hasMicrophone});

  // builds the widget onto the screen
  @override
  Widget build(BuildContext context) {
    bool _isPasswordField = isPasswordField ?? false;
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 24.0,
      ),
      decoration: BoxDecoration(
          color: Color(0xFFF2F2F2),
          borderRadius: BorderRadius.circular(12.0)
      ),
      child: TextField(
        obscureText: _isPasswordField,
        focusNode: focusNode,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        textInputAction: textInputAction,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText ?? "Hint Text...",
            contentPadding: EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 20.0,
            )
        ),
        style: Constants.regularDarkText,
      ),
    );
  }
}