import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class TextFieldWidget extends StatelessWidget {
  final String hintText;
  final IconData prefixIconData;

  TextFieldWidget({
    required this.hintText,
    required this.prefixIconData,
  });

  @override
  Widget build(BuildContext context) {

    return TextField(
      style: TextStyle(
        color: CupertinoColors.activeBlue,
        fontSize: 14.0,
      ),
      cursorColor: CupertinoColors.activeBlue,
      decoration: InputDecoration(
        labelText: hintText,
        prefixIcon: Icon(
          prefixIconData,
          size: 18.0,
          color: CupertinoColors.activeBlue,
        ),
        filled: true,
        enabledBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: CupertinoColors.activeBlue,
          ),
        ),
        labelStyle: TextStyle(
          color: CupertinoColors.activeBlue,
        ),
        focusColor: CupertinoColors.activeBlue,
      ),
    );
  }
}
