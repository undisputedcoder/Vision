import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_cupertino_settings/flutter_cupertino_settings.dart';
import 'package:apple/Screens/licenses.dart';
import 'package:apple/Screens/version.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool switchState = false;
  bool safeModeSwitch = false;
  int current = 0;

  CSWidgetStyle safeModeStyle = const CSWidgetStyle(
    icon: const Icon(
      Icons.health_and_safety,
      color: CupertinoColors.systemGreen,
    )
  );

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Settings'),
      ),
      child: CupertinoSettings(
          items: <Widget>[
            const CSHeader('Safety'),
            CSControl(
              nameWidget: Text('User Safe mode'),
              contentWidget: CupertinoSwitch(
                value: safeModeSwitch,
                activeColor: CupertinoColors.activeBlue,
                onChanged: (bool value) {
                  setState(() {
                    safeModeSwitch = value;
                  });
                },
              ),
              style: safeModeStyle,
            ),
            CSDescription('If you are operating with machinery then enable this mode. Enabling safe mode will ensure the app does not become a distraction.',),
            const CSHeader('Theme'),
            CSControl(
              nameWidget: Text('Dark mode'),
              contentWidget: CupertinoSwitch(
                value: switchState,
                activeColor: CupertinoColors.activeBlue,
                onChanged: (bool value) {
                  setState(() {
                    switchState = value;
                  });
                },
              ),
            ),
            CSHeader('Theme'),
            CSSelection<int>(
              items: const <CSSelectionItem<int>>[
                CSSelectionItem<int>(
                    text: 'System (Default)',
                    value: 0
                ),
                CSSelectionItem<int>(
                    text: 'Light mode',
                    value: 1
                ),
                CSSelectionItem<int>(
                    text: 'Dark mode',
                    value: 2
                ),

              ],
              onSelected: (index) {
                setState(() {
                  current = index;
                });
              },
              currentSelection: current,
            ),
            const CSHeader('About Vision'),
            CSButton(CSButtonType.DEFAULT, "Version", (){
              Navigator.push(
                  context,
                  CupertinoPageRoute(builder: (context) => Version())
              );
            }),
            CSButton(CSButtonType.DEFAULT, "View Licenses", () {
              Navigator.push(
                  context,
                  CupertinoPageRoute(builder: (context) => Licenses())
              );
            }),
          ]
      ),
    );
  }
}



