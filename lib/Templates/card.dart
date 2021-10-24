import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget info(String title, double val, double percent) {
  return Column(
    children: [
      Align(
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            Text(
              "$title ",
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            Icon(CupertinoIcons.info_circle_fill,
                size: 15),
          ],
        ),
      ),
      Align(
        alignment: Alignment.centerLeft,
        child: Text(
          '\$$val',
          style: TextStyle(
            fontSize: 24,
          ),
        ),
      ),
      Align(
        alignment: Alignment.centerLeft,
        child: Text(
          "\u{2191} $percent%",
          style: TextStyle(
              fontSize: 14, color: Colors.green),
        ),
      ),
    ],
  );
}