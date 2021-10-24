import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showProdInfo(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text("Production"),
        content: Text("Production is blah blah blah"),
        actions: [
          CupertinoDialogAction(
            child: Text("OK"),
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      )
  );
}

void showTenderInfo(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text("Tender"),
        content: Text("Tender is blah blah blah"),
        actions: [
          CupertinoDialogAction(
            child: Text("OK"),
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ))
  ;
}

void showHelp(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text("Info"),
        content: Text("Blah blah blah"),
        actions: [
          CupertinoDialogAction(
            child: Text("OK"),
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      )
  );
}