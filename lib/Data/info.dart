import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showProdInfo(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text("Production & Presplit"),
        content: Text("Metres drilled for production and presplit drilling."),
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

void showPresplitInfo(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text("Presplit"),
        content: Text("Meters drilled for pre-split drilling."),
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
        content: Text("Planned meters drilled for pre-split and production drilling."),
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
        content: Text(""),
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