import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Settings'),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(30.0, 110.0, 30.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Appearance',
              style: TextStyle(),
            ),
            Divider(
              height: 22.5,
              color: Colors.black,
            ),
            Text(
              'Theme',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Dark'),
                Transform.scale(
                  scale: 0.7,
                  child: CupertinoButton(
                    child: CupertinoSwitch(
                      value: false,
                      onChanged: (bool value) {},
                      activeColor: CupertinoColors.activeBlue,
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              'About Vision',
              style: TextStyle(),
            ),
            Divider(
              height: 22.5,
              color: Colors.black,
            ),
            Text(
              'Version',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Text('0.0.0'),
          ],
        ),
      ),
    );
  }
}
