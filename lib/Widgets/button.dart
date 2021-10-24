import 'package:apple/Authentication/local_auth_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:apple/Screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ButtonWidget extends StatelessWidget {
  final String title;
  final bool hasBorder;
  final User user;


  ButtonWidget({
    required this.title,
    required this.hasBorder,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Ink(
        decoration: BoxDecoration(
          color: hasBorder ? CupertinoColors.white : Color(0xff00b09b),
          borderRadius: BorderRadius.circular(10.0),
          border: hasBorder
              ? Border.all(
                  color: Color(0xff00b09b),
                  width: 1.0,
                )
              : Border.fromBorderSide(BorderSide.none),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(10.0),
          child: Container(
            height: 60.0,
            child: Center(
              child: TextButton(
                onPressed: () async {
                  final localAuthIsAvail =
                      await LocalAuthApi.localAuthIsAvail();

                  if (localAuthIsAvail) {
                    final authenticationSuccessful =
                        await LocalAuthApi.authenticate();

                    if (authenticationSuccessful) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => HomePage(user: user)),
                      );
                    }
                  } else {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => HomePage(user: user)),
                    );
                  }
                },
                child: Text(
                  title,
                  style: TextStyle(
                    color:
                        hasBorder ? Color(0xff00b09b) : CupertinoColors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
