import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Licenses extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: CupertinoButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Icon(
                CupertinoIcons.back
            )
        ),
        middle: Text('Licenses'),
      ),
      child: Container(),
    );
  }
}