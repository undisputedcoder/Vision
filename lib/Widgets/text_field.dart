import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class TextFieldWidget extends StatelessWidget {
  final String hintText;
  final IconData prefixIconData;
  final bool obscureText;

  TextFieldWidget({
    required this.hintText,
    required this.prefixIconData,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {

    return TextField(
      obscureText: obscureText,
      style: TextStyle(
        color: Color(0xff00b09b),
        fontSize: 14.0,
      ),
      cursorColor: Color(0xff00b09b),
      decoration: InputDecoration(
        labelText: hintText,
        prefixIcon: Icon(
          prefixIconData,
          size: 18.0,
          color: Color(0xff00b09b),
        ),
        filled: true,
        enabledBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: Color(0xff00b09b),
          ),
        ),
        labelStyle: TextStyle(
          color: Color(0xff00b09b),
        ),
        focusColor: Color(0xff00b09b),
      ),
    );
  }
}
