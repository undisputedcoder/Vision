import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_cupertino_settings/flutter_cupertino_settings.dart';
import 'package:apple/Screens/version.dart';

class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  bool switchState = false;
  bool safeModeSwitch = true;
  int current = 0;

  CSWidgetStyle safeModeStyle = const CSWidgetStyle(
      icon: const Icon(
    Icons.health_and_safety,
    color: CupertinoColors.activeGreen,
  ));

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Settings'),
      ),
      child: CupertinoSettings(items: <Widget>[
        const CSHeader('Safety'),
        CSControl(
          nameWidget: Text('User Safe Mode'),
          contentWidget: CupertinoSwitch(
            value: safeModeSwitch,
            activeColor: CupertinoColors.activeGreen,
            onChanged: (bool value) {
              setState(() {
                safeModeSwitch = value;
              });
            },
          ),
          style: safeModeStyle,
        ),
        CSDescription(
            'User Safe Mode prevents the app from becoming a distraction while operating machinery.'),
        CSHeader('Theme'),
        CSSelection<int>(
          items: const <CSSelectionItem<int>>[
            CSSelectionItem<int>(text: 'System (Default)', value: 0),
            CSSelectionItem<int>(text: 'Light', value: 1),
            CSSelectionItem<int>(text: 'Dark', value: 2),
          ],
          onSelected: (index) {
            setState(() {
              current = index;
            });
          },
          currentSelection: current,
        ),
        const CSHeader('About Vision'),
        CSButton(CSButtonType.DEFAULT, "Version", () {
          Navigator.push(
              context, CupertinoPageRoute(builder: (context) => Version()));
        }),
      ]),
    );
  }
}
