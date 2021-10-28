import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showProdInfo(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text("Production"),
        content: Text("The cost incurred from making or manufacturing components or raw materials."),
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
        content: Text("The total of production and pre-split."),
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