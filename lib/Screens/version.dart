import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Version extends StatelessWidget {

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
        middle: Text('Version History'),
      ),
      child: Container(),
    );
  }
}
