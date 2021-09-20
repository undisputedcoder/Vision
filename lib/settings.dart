import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_cupertino_settings/flutter_cupertino_settings.dart';
import 'licenses.dart';
import 'version.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool switchState = false;
  int current = 0;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Settings'),
      ),
      child: CupertinoSettings(
          items: <Widget>[
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
                    text: 'Light mode (default)',
                    value: 0
                ),
                CSSelectionItem<int>(
                    text: 'Dark mode',
                    value: 1
                ),
              ],
              onSelected: (index) {
                setState(() {
                  current = index;
                });
              },
              currentSelection: current,
            ),
            CSDescription('Using Night mode extends battery life on devices with OLED display',),
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



