import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:settings_ui/settings_ui.dart';

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
      child: SettingsList(
        backgroundColor: CupertinoColors.white,
        sections: [
          SettingsSection(
            titlePadding: EdgeInsets.all(20),
            title: 'Appearance',
            titleTextStyle: TextStyle(
              color: CupertinoColors.black,
              fontWeight: FontWeight.bold,
            ),
            tiles: [
              SettingsTile.switchTile(
                title: 'Use System Theme',
                leading: Icon(CupertinoIcons.device_phone_portrait),
                onToggle: (value) {},
                switchValue: true,
                switchActiveColor: CupertinoColors.activeBlue,
              ),
            ],
          ),
          SettingsSection(
            titlePadding: EdgeInsets.all(20),
            title: 'About Vision',
            titleTextStyle: TextStyle(
              color: CupertinoColors.black,
              fontWeight: FontWeight.bold,
            ),
            tiles: [
              SettingsTile(
                title: 'Version',
                subtitle: '0.0.0',
                leading: Icon(CupertinoIcons.clock),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
