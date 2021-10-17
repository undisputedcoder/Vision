import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:apple/Api/local_auth_api.dart';
import 'package:apple/Screens/home.dart';

class ButtonWidget extends StatelessWidget {
  final String title;
  final bool hasBorder;

  ButtonWidget({
    required this.title,
    required this.hasBorder,
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
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                    }
                  } else {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => HomePage()),
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
