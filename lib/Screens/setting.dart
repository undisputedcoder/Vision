import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_cupertino_settings/flutter_cupertino_settings.dart';
import 'package:apple/Screens/version.dart';
import 'package:apple/Screens/home.dart';
import 'package:apple/Theme/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:apple/globals.dart';

class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

ThemeData _lightTheme = ThemeData(
    accentColor: Colors.pink,
    brightness: Brightness.light,
    primaryColor: Colors.blue
);

ThemeData _darkTheme = ThemeData(
  accentColor: Colors.red,
  brightness: Brightness.dark,
  primaryColor: Colors.amber
);

class _SettingState extends State<Setting> {
  bool switchState = false;
  //bool safeModeSwitch = true;
  int current = 0;

  CSWidgetStyle safeModeStyle = const CSWidgetStyle(
      icon: const Icon(
    Icons.health_and_safety,
    color: CupertinoColors.activeGreen,
  ));

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Settings'),
      ),
      child: CupertinoSettings(items: <Widget>[
        const CSHeader('Safety'),
        CSControl(
          nameWidget: Text('User Safe Mode'),
          contentWidget: CupertinoSwitch(
            value: userSafeModeSwitch,
            activeColor: CupertinoColors.activeGreen,
            onChanged: (bool value) {
              setState(() {
                userSafeModeSwitch = value;
                print(userSafeModeSwitch); // Remove later
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
            final provider = Provider.of<ThemeProvider>(context, listen: false);
            provider.toggleTheme(index);
            setState(() {
              current = index;
            });
          },
          currentSelection: current,
        ),
      ]),
    );
  }
}

