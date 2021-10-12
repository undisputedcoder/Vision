import 'dart:async';
import 'package:flutter/material.dart';
import 'package:apple/Screens/login.dart';
import 'package:flutter/cupertino.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 2),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginPage())));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CupertinoColors.white,
      child: Transform.scale(
        scale: 0.4,
        child: const Image(
          image: AssetImage(
            'Assets/splash.png',
          ),
        ),
      ),
    );
  }
}