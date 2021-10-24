import 'dart:async';
import 'package:apple/Templates/gradient.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../globals.dart';

checkUserSafeModeSwitch(subscription) {
  if (userSafeModeSwitch == true) {
    if (subscription.isPaused) {
      subscription.resume();
    }
  }

  if (userSafeModeSwitch == false) {
    if (!subscription.isPaused) {
      subscription.pause();
    }
  }
}

checkUserAccelerometer(BuildContext context) {
  var subscription;
  double kilometersPerHour = 0.0;
  bool isPassenger = false;
  const double averageRunningSpeed = 9.4;
  int count = 0;

  subscription = Geolocator.getPositionStream(
      intervalDuration: const Duration(seconds: 3),
      desiredAccuracy: LocationAccuracy.high)
      .listen((position) {
    const oneSecond = Duration(seconds: 1);
    Timer.periodic(oneSecond, (Timer t) => checkUserSafeModeSwitch(subscription));
    kilometersPerHour = position.speed * 3.6;
    print(kilometersPerHour); // Remove later

    if (kilometersPerHour > averageRunningSpeed) {
      if (count < 3) {
        ++count;
      }

      if (!isPassenger && count == 3) {
        showAlert(context);
        isPassenger = true;
      }
    }
  });
}

void showAlert(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text("You're going too fast!"),
        content: Column(
          children: const <Widget>[
            SizedBox(
              height: 10.0,
            ),
            IconGradient(
              CupertinoIcons.speedometer,
              125.0,
              LinearGradient(
                colors: <Color>[
                  CupertinoColors.systemYellow,
                  CupertinoColors.systemOrange,
                  CupertinoColors.systemRed,
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
                'This app should not be used while operating machinery.'),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => {
              Navigator.pop(context, "I'M A PASSENGER"),
            },
            child: const Text("I'M A PASSENGER"),
          ),
        ],
      ));
}